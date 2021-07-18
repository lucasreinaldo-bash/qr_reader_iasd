import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUsersSubscriber extends StatelessWidget {
  final String documentId;

  GetUsersSubscriber(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference subscriber = Firestore.instance.collection("Inscritos");

    return FutureBuilder<DocumentSnapshot>(
      future: subscriber.document(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data;
          return Text("Full Name: ${data['nome']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("This is a Custom Toast"),
      ],
    ),
  );
}
