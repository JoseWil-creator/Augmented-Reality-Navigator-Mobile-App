import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unitrail/views/Components/Building_LatLng.dart';
import 'package:unitrail/views/Components/rounded_button.dart';
import 'package:unitrail/views/preview.dart';

final X011 = "AIzaSyA_Vo63tEnW8Fd5AMqx9NjqWTOXef8Cc1k";

class GMap extends StatefulWidget {
  final String X0; //Start building
  final String X1; //Destination building

  const GMap({required this.X0, required this.X1});

  @override
  _GMap createState() => _GMap();
}

class _GMap extends State<GMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  var reach = false;
  var min_dist = 0.0005;

  LatLng _center = const LatLng(39.7439, -105.0047);
  final LatLng boxNE = const LatLng(39.746692, -105.000814);
  final LatLng boxSW = const LatLng(39.741209, -105.010962);
  BitmapDescriptor destIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor curIcon = BitmapDescriptor.defaultMarker;
  List<LatLng> polyLineCords = [];
  LocationData? currentLoc;

  void getCurrentLocation() async {
    LatLng origin = buildingLL[widget.X0.split(" ")[0]]!;
    LatLng dest = buildingLL[widget.X1.split(" ")[0]]!;
    Location loc = Location();

    loc.getLocation().then((value) => currentLoc = value);
    GoogleMapController gMapCont = await _controller.future;

    gMapCont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 18.2,
        target: LatLng(currentLoc!.latitude!, currentLoc!.longitude!))));
  }

  void updateLocation() {
    LatLng dest = buildingLL[widget.X1.split(" ")[0]]!;
    Location loc = Location();
    loc.onLocationChanged.listen((event) async {
      currentLoc = event;
      await getPolyPoints(
          LatLng(currentLoc!.latitude!, currentLoc!.longitude!), dest);
      //Get the current distance user is from destination
      var curDist = sqrt(pow((currentLoc!.latitude! - dest.latitude), 2) +
          pow((currentLoc!.longitude! - dest.longitude), 2));
      //If we are within range display arrive button
      if (curDist <= min_dist) {
        reach = true;
      }
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

  void addCustomIcon1() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/logo_icon_small.png")
        .then(
      (icon) {
        setState(() {
          destIcon = icon;
        });
      },
    );
  }

  void addCustomIcon2() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/icon_grad_cap_small.png")
        .then(
      (icon) {
        setState(() {
          curIcon = icon;
        });
      },
    );
  }

  @override
  void initState() {
    LatLng origin = buildingLL[widget.X0.split(" ")[0]]!;
    LatLng dest = buildingLL[widget.X1.split(" ")[0]]!;
    getCurrentLocation();
    addCustomIcon1();
    addCustomIcon2();
    getPolyPoints(origin, dest);
    super.initState();
    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Color.fromARGB(255, 126, 133, 194),
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('MSU Campus'),
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
                        color: Color.fromARGB(246, 227, 27, 20),
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
                        icon: curIcon,
                      ),
                      Marker(
                        markerId: MarkerId("Destination"),
                        position: buildingLL[widget.X1.split(" ")[0]]!,
                        icon: destIcon,
                      )
                    },
                  ),
            floatingActionButton: Visibility(
                visible: reach,
                child: ElevatedButton(
                  child: Text("Arrived At Building"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        //print(widget.X1.split(" ")[0] + "_Entrance");
                        //print(widget.X1.replaceAll(" ", "_"));
                        return UnityDemoScreen(
                            start: widget.X1.split(" ")[0] + "_Entrance",
                            end: widget.X1.replaceAll(" ", "_"));
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(178, 13, 217, 84),
                  ),
                ))));
  }
}
