import 'dart:convert';

List<Data> dataFromJson(String str) => List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  Links? links;
  String name;
  DateTime dateUtc;
  String id;

  Data({
    required this.links,
    required this.name,
    required this.dateUtc,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        links: json["links"] != null ? Links.fromJson(json["links"]) : null,
        name: json["name"] ?? "Unknown",
        dateUtc: json["date_utc"] != null ? DateTime.parse(json["date_utc"]) : DateTime.now(),
        id: json["id"] ?? "Unknown",
      );

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
        "name": name,
        "date_utc": dateUtc.toIso8601String(),
        "id": id,
      };
}

class Links {
  Patch? patch;

  Links({
    required this.patch,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        patch: json["patch"] != null ? Patch.fromJson(json["patch"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "patch": patch?.toJson(),
      };
}

class Patch {
  String small;
  String large;

  Patch({
    required this.small,
    required this.large,
  });

  factory Patch.fromJson(Map<String, dynamic> json) => Patch(
        small: json["small"] ?? "",
        large: json["large"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
      };
}
