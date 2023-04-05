import 'package:flutter/material.dart';
import 'package:unitrail/BackEndTesting/crud.dart';
import 'components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_choices/search_choices.dart';

class BackendTesting extends StatefulWidget {
  const BackendTesting({super.key});

  @override
  _BackendTestingState createState() => _BackendTestingState();
}

class _BackendTestingState extends State<BackendTesting> {
  //Variables to hold responses to search_choices
  var start;
  var dest;

  @override
  Widget build(BuildContext context) {
    //readData() returns all buildings and all rooms currently stored in the database
    Future<List<DropdownMenuItem<String>>> readData() async {
      CollectionReference buildings =
          FirebaseFirestore.instance.collection("Buildings");
      //print(buildings.get());
      //Secondary function to assure async executiong
      Future<List<DropdownMenuItem<String>>> db_call() async {
        //get list of buldings
        List<DropdownMenuItem<String>> buildRooms = [];
        var buildSnap = await buildings.get();
        //print(buildSnap);
        //print("got buildsnap");
        //Buildrooms is the final list object we aggregate for the search_choice widget
        //For all buildings
        //print(buildSnap.docs);
        for (var building in buildSnap.docs) {
          //print(building);
          var floorsnap =
              await buildings.doc(building.id).collection("Floors").get();
          //For every floor on current building
          //print(floorsnap);
          //print("got floorsnap");
          for (var floor in floorsnap.docs) {
            //print(floor.id);
            var roomsnap = await buildings
                .doc(building.id)
                .collection("Floors")
                .doc(floor.id)
                .get();
            var data;
            //Null check room documents
            if (roomsnap.exists) {
              data = await roomsnap.data();
            }
            //For every room on given floor
            for (var room in data.keys) {
              //create dropDownMenuItem with string of "building" + "room #"
              //print("all the way here");
              var toAdd = await (DropdownMenuItem(
                value: building.id + room,
                child: Text(building.id + room),
              ));
              buildRooms.add(toAdd);
            }
          }
        }
        //First function return
        return buildRooms;
      }

      //final async return call
      return await db_call();
    }

    Size size = MediaQuery.of(context)
        .size; // This provides the total width and height of our screen
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          //Widget list for given page.
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            const Text(
              "Testing",
              style: TextStyle(
                color: Color.fromARGB(255, 1, 16, 129),
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: size.height * 0.1),

            Text("Begining"),

            //Future Builder for start location searchChoices
            FutureBuilder(
                future: readData(),
                builder: (context,
                    AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var buildRooms = snapshot.data;
                    //print(buildRooms);
                    return SearchChoices.single(
                      items: buildRooms,
                      value: start,
                      hint: "Select one",
                      searchHint: "Select one",
                      onChanged: (value) {
                        setState(() {
                          start = value;
                        });
                      },
                      isExpanded: true,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),

            Text("Destination"),

            //Future Builder for Destination Search choices
            FutureBuilder(
                future: readData(),
                builder: (context,
                    AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var buildRooms = snapshot.data;
                    //print(buildRooms);
                    return SearchChoices.single(
                      items: buildRooms,
                      value: dest,
                      hint: "Select one",
                      searchHint: "Select one",
                      onChanged: (value) {
                        setState(() {
                          dest = value;
                        });
                      },
                      isExpanded: true,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),

            //Crud testing button
            RoundedButton(
              text: "CRUD",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Crud();
                    },
                  ),
                );
              },
            ),

            //Navigate testing button
            RoundedButton(
              text: "Navigate",
              press: () {
                print("Start: " + start);
                print("Destination: " + dest);
              },
            ),
          ],
        ),
      ),
    );
  }
}
