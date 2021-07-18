import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriberData {
  String nome, id, email, telefone, registro_chegada;
  bool presente;

  SubscriberData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    nome = snapshot.data["nome"];
    email = snapshot.data["email"];
    telefone = snapshot.data["telefone"];

    registro_chegada = snapshot.data["registro_chegada"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "nome": nome,
      "email": email,
      "telefone": telefone,
      "registro_chegada": registro_chegada
    };
  }
}
