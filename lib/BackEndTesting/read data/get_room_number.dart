import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class GetRoomNumber extends StatelessWidget {
  final String documentId;

  const GetRoomNumber({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    // get the collection
    DocumentReference buildings = FirebaseFirestore.instance
        .collection("Buildings")
        .doc("AES")
        .collection("Floors")
        .doc(documentId);

    return FutureBuilder<DocumentSnapshot>(
        future: buildings.get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            // print(data['Rooms']);
            return Text('Room: ${data['Rooms']}');
          }
          return const Text('loading..');
        }));
  }
}
