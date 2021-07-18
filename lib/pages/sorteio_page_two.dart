import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderiasd/pages/sorteio_page.dart';
import 'package:qrreaderiasd/utilitys/style.dart';

class SorteioPageTwo extends StatefulWidget {
  @override
  _SorteioPageTwoState createState() => _SorteioPageTwoState();
}

class _SorteioPageTwoState extends State<SorteioPageTwo> {
  Random random = new Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SorteioPage()));
            },
            child: Icon(Icons.refresh),
          )
        ],
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "Sorteado",
          style: styleCleanAppBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("Inscritos")
                  .where("presente", isEqualTo: true)
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  timerRolete();
                  return Center(
                    child: Container(
                        width: 300,
                        height: 300,
                        child: FlareActor("assets/rolete.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "darting lr")),
                  );
                } else {
                  return Center(
                      child: Column(
                    children: [
                      Container(
                          width: 300,
                          height: 300,
                          child: FlareActor("assets/rolete.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "darting lr")),
                      Container(
                        height: 400,
                        width: 400,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (_, index) {
                            int numberRandom =
                                random.nextInt(snapshot.data.documents.length);

                            return ListTile(
                              title: Text(
                                snapshot
                                    .data.documents[numberRandom].data["nome"],
                                textAlign: TextAlign.center,
                                style: styleCleanTitle,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  timerRolete() async {
    await Future.delayed(Duration(seconds: 3), () {});
  }
}
