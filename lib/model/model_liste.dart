class Liste {
  int id_liste;
  String title;

  Liste({this.id_liste, this.title});

  //transforms a json into an object of type Categories
  factory Liste.fromJson(Map<String, dynamic> Json) {
    return Liste(
      id_liste: Json['id_liste'],
      title: Json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_liste": id_liste,
        "title": title
      };
}
