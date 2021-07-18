import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderiasd/pages/sorteio_page.dart';
import 'package:qrreaderiasd/pages/subscriber_screen.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final GlobalKey drawer = new GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: <Widget>[
        Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/background_drawer.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: null /* add child content content here */
            ),
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            Divider(),
            _createDrawerItem(
              icon: Icons.library_books,
              text: 'Lista de Inscritos',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriberScreen()));
              },
            ),
            _createDrawerItem(
              icon: Icons.star,
              text: 'Sorteio',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SorteioPage()));
              },
            ),
            Divider(),
          ],
        )
      ],
    ));
  }

  Widget _createHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          Center(
              child: Card(
            elevation: 40,
            color: Color(0xFFEFD8AF),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100.0),
                side: BorderSide(color: Colors.white)),
            child: Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.contain,
                      image: new NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/iasd-5f9b9.appspot.com/o/logo.png?alt=media&token=916aeba1-362b-44b6-b0c0-98711c127a5b"),
                    ))),
          )),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
