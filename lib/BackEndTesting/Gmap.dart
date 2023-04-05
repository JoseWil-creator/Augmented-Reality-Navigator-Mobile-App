import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unitrail/views/Components/Building_LatLng.dart';

final X011 = "AIzaSyA_Vo63tEnW8Fd5AMqx9NjqWTOXef8Cc1k";

class GMapTest extends StatefulWidget {
  const GMapTest({super.key});

  @override
  _GMapTest createState() => _GMapTest();
}

class _GMapTest extends State<GMapTest> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  LatLng _center = const LatLng(39.7439, -105.0047);
  LatLng origin = buildingLL["AES"]!;
  LatLng dest = buildingLL["Science"]!;
  final LatLng boxNE = const LatLng(39.746692, -105.000814);
  final LatLng boxSW = const LatLng(39.741209, -105.010962);

  List<LatLng> polyLineCords = [];
  LocationData? currentLoc;

  void getCurrentLocation() async {
    Location loc = Location();

    loc.getLocation().then((value) => currentLoc = value);
    GoogleMapController gMapCont = await _controller.future;

    loc.onLocationChanged.listen((event) async {
      currentLoc = event;

      gMapCont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 18.2, target: LatLng(event.latitude!, event.longitude!))));
      await getPolyPoints(LatLng(currentLoc!.latitude!, currentLoc!.longitude!), dest);
      setState(() {});
    });
  }

  Future<void> getPolyPoints(ori, des) async {
    PolylinePoints plp = PolylinePoints();
    polyLineCords = [];

    PolylineResult result = await plp.getRouteBetweenCoordinates(
        X011,
        PointLatLng(ori.latitude, ori.longitude),
        PointLatLng(des.latitude, des.longitude),
        travelMode: TravelMode.walking);

    if (result.points.isNotEmpty) {
      result.points.forEach((point) {
        polyLineCords.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints(origin, dest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green[700],
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Maps Sample App'),
              elevation: 2,
            ),
            body: currentLoc == null
                ? const Center(child: const CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                    initialCameraPosition: CameraPosition(
                      target:
                          LatLng(currentLoc!.latitude!, currentLoc!.longitude!),
                      zoom: 15.0,
                    ),
                    polylines: {
                      Polyline(
                        polylineId: PolylineId("Route"),
                        points: polyLineCords,
                        color: Colors.blue,
                        width: 5,
                      )
                    },
                    cameraTargetBounds: CameraTargetBounds(
                        LatLngBounds(northeast: boxNE, southwest: boxSW)),
                    markers: {
                      Marker(
                        markerId: const MarkerId("Current"),
                        position: LatLng(
                            currentLoc!.latitude!, currentLoc!.longitude!),
                      ),
                      Marker(
                        markerId: MarkerId("Destination"),
                        position: dest,
                      )
                    },
                  )));
  }
}
