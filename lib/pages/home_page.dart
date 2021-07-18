import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrreaderiasd/utilitys/style.dart';
import 'package:qrreaderiasd/widgets/drawer.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../subscribe_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode myFocusPesquisa = FocusNode();

  final _pesquisaController = TextEditingController();

  String nomePesquisado = "nenhum";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Icon(Icons.qr_code_rounded),
                Text(
                  "QRScanner",
                  style: styleCleanTitle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextField(
                  onChanged: (string) {
                    setState(() {
                      nomePesquisado = string.toUpperCase().trim();
                    });
                  },
                  focusNode: myFocusPesquisa,
                  controller: _pesquisaController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 13.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      onTap: () async {
                        String cameraScanResult = await scanner.scan();

                        _pesquisaController.text = cameraScanResult;

                        setState(() {
                          nomePesquisado =
                              _pesquisaController.text.toUpperCase();
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20.0,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText:
                        "Digite o nome do participante ou clique na lupa para ler o QR",
                    hintStyle: TextStyle(fontFamily: "Georgia", fontSize: 10.0),
                  ),
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("Inscritos")
                  .where("nome", isEqualTo: nomePesquisado)
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                      child: Container(
                    height: 600,
                    width: 400,
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        SubscriberData data = SubscriberData.fromDocument(
                            snapshot.data.documents[index]);
                        return Column(
                          children: [
                            Text(
                              data.nome,
                              textAlign: TextAlign.center,
                              style: styleCleanTitle,
                            ),
                            Text(
                              data.email,
                              style: styleCleanSubTitle,
                            ),
                            Text(
                              data.telefone,
                              style: styleCleanSubTitle,
                            ),
                            QrImage(
                              data: data.nome,
                              version: QrVersions.auto,
                              size: 90,
                              gapless: true,
                            ),
                            Container(
                                width: 100,
                                height: 100,
                                child: FlareActor("assets/checker.flr",
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    animation: "play")),
                            Text(
                              "Entrada Permitida",
                              style: styleCleanTitle,
                            ),
                            data.registro_chegada == "não chegou"
                                ? Container()
                                : Text(
                                    "Registro de Chegada: " +
                                        data.registro_chegada,
                                    textAlign: TextAlign.center,
                                    style: styleCleanRegistroChegada,
                                  ),
                            SizedBox(
                              height: 30,
                            ),
                            Card(
                                child: FlatButton(
                              onPressed: () async {
                                await Firestore.instance
                                    .collection("Inscritos")
                                    .document(snapshot
                                        .data.documents[index].documentID)
                                    .updateData({
                                  "presente": true,
                                  "registro_chegada": formatDate(DateTime.now(),
                                          [dd, '/', mm, '/', yyyy]) +
                                      " às ${formatDate(DateTime.now(), [
                                        HH,
                                        ':',
                                        nn,
                                        ':',
                                        ss
                                      ])}"
                                });
                                setState(() {});
                              },
                              child: Text(
                                "Confirmar Chegada",
                                style: styleCleanSubTitle,
                              ),
                            ))
                          ],
                        );
                      },
                    ),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
