import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderiasd/utilitys/style.dart';

import '../subscribe_data.dart';

class SubscriberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Inscrições Deferidas",
          style: styleCleanAppBarTitle,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("Inscritos").getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Card(
                        elevation: 6,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data.documents.length.toString(),
                                style: styleCleanTitle,
                              ),
                              Text(
                                "Inscritos",
                                style: styleCleanSubTitle,
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                          child: Container(
                        height: 600,
                        width: 400,
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            SubscriberData data = SubscriberData.fromDocument(
                                snapshot.data.documents[index]);
                            return Card(
                              child: ListTile(
                                title: Text(
                                  data.nome,
                                  style: styleCleanTitle,
                                ),
                                subtitle: Text(
                                  data.telefone,
                                  style: styleCleanSubTitle,
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
