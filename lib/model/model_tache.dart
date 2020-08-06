import 'package:flutter/cupertino.dart';

class Tache {
  int id_tache;
  String title;
  DateTime date;
  int id_liste;
  int status;

  Tache({this.id_liste,@required this.title,this.date,@required this.id_tache,this.status});

  //transforms a json into an object of type Categories
  factory Tache.fromJson(Map<String, dynamic> Json) {
    return Tache(
      id_tache: Json['id_tache'],
      title: Json['title'],
      id_liste: Json['id_liste'],
      date: DateTime.parse(Json['date']),
      status: Json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_tache": id_tache,
        "title": title,
        "date": date.toString(),
        "id_liste": id_liste,
        "status": status,
      };
}
