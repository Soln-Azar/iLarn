import 'dart:convert';

Res ResFromJson(String str) => Res.fromJson(json.decode(str));

String ResToJson(Res data) => json.encode(data.toJson());

class Res {
  Res({
    required this.Manipulateds,
  });

  List<Manipulated> Manipulateds;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
        Manipulateds: List<Manipulated>.from(
            json["organic_results"].map((x) => Manipulated.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "organic_results":
            List<dynamic>.from(Manipulateds.map((x) => x.toJson())),
      };
}

class Manipulated {
  Manipulated({
    required this.title,
    required this.link,
    required this.snippet,
  });

  String title;
  String link;
  String snippet;

  factory Manipulated.fromJson(Map<String, dynamic> json) => Manipulated(
        title: json["title"],
        link: json["link"],
        snippet: json["snippet"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "snippet": snippet,
      };
}
