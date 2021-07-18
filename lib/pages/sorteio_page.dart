import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderiasd/pages/sorteio_page_two.dart';
import 'package:qrreaderiasd/utilitys/style.dart';

class SorteioPage extends StatefulWidget {
  @override
  _SorteioPageState createState() => _SorteioPageState();
}

class _SorteioPageState extends State<SorteioPage> {
  Random random = new Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timerRolete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "Sorteio",
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
    await Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SorteioPageTwo()));
    });
  }
}
