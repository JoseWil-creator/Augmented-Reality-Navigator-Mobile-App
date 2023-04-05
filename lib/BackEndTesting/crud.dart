import 'package:flutter/material.dart';
import 'components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/rounded_input_field.dart';

class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  _Crud createState() => _Crud();
}

class _Crud extends State<Crud> {
  late String buildingName, floorNumber, roomNumber;

  getBuildingName(name) {
    buildingName = name;
  }

  getFloor(floor) {
    floorNumber = floor;
  }

  getRoom(room) {
    roomNumber = room;
  }

  readData() {
    DocumentReference buildings = FirebaseFirestore.instance
        .collection("Buildings")
        .doc(buildingName)
        .collection("Floors")
        .doc(floorNumber);

    buildings.get().then((snapshot) {
      print(buildingName + snapshot.get(roomNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            const Text(
              "CRUD",
              style: TextStyle(
                  color: Color.fromARGB(255, 1, 16, 129),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            // Empty box to create white space
            SizedBox(height: size.height * 0.1),
            // Building text field
            RoundedInputField(
              hintText: "Building",
              onChanged: (String building) {
                getBuildingName(building.toUpperCase());
              },
            ),
            RoundedInputField(
              hintText: "Floor",
              onChanged: (String floor) {
                getFloor(floor.toLowerCase());
              },
            ),
            RoundedInputField(
              hintText: "Room",
              onChanged: (String room) {
                getRoom(room.toUpperCase());
              },
            ),
            RoundedButton(
              text: "Read",
              press: () {
                readData();
              }),
            // Empty box to create white space
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
