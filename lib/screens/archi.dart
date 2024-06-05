import 'package:hive/hive.dart';
import 'package:spacexview/screens/data.g.dart';

@HiveType(typeId: 0)
class Data extends HiveObject {
  @HiveField(0)
  Fairings fairings;
  @HiveField(1)
  Links links;
  @HiveField(2)
  DateTime staticFireDateUtc;
  @HiveField(3)
  int staticFireDateUnix;
  @HiveField(4)
  bool net;
  @HiveField(5)
  int window;
  @HiveField(6)
  String rocket;
  @HiveField(7)
  bool success;
  @HiveField(8)
  List<Failure> failures;
  @HiveField(9)
  String details;
  @HiveField(10)
  List<dynamic> crew;
  @HiveField(11)
  List<dynamic> ships;
  @HiveField(12)
  List<dynamic> capsules;
  @HiveField(13)
  List<String> payloads;
  @HiveField(14)
  String launchpad;
  @HiveField(15)
  int flightNumber;
  @HiveField(16)
  String name;
  @HiveField(17)
  DateTime dateUtc;
  @HiveField(18)
  int dateUnix;
  @HiveField(19)
  DateTime dateLocal;
  @HiveField(20)
  String datePrecision;
  @HiveField(21)
  bool upcoming;
  @HiveField(22)
  List<Core> cores;
  @HiveField(23)
  bool autoUpdate;
  @HiveField(24)
  bool tbd;
  @HiveField(25)
  dynamic launchLibraryId;
  @HiveField(26)
  String id;

  Data({
    required this.fairings,
    required this.links,
    required this.staticFireDateUtc,
    required this.staticFireDateUnix,
    required this.net,
    required this.window,
    required this.rocket,
    required this.success,
    required this.failures,
    required this.details,
    required this.crew,
    required this.ships,
    required this.capsules,
    required this.payloads,
    required this.launchpad,
    required this.flightNumber,
    required this.name,
    required this.dateUtc,
    required this.dateUnix,
    required this.dateLocal,
    required this.datePrecision,
    required this.upcoming,
    required this.cores,
    required this.autoUpdate,
    required this.tbd,
    required this.launchLibraryId,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fairings: Fairings.fromJson(json["fairings"]),
    links: Links.fromJson(json["links"]),
    staticFireDateUtc: DateTime.parse(json["static_fire_date_utc"]),
    staticFireDateUnix: json["static_fire_date_unix"],
    net: json["net"],
    window: json["window"],
    rocket: json["rocket"],
    success: json["success"],
    failures: List<Failure>.from(json["failures"].map((x) => Failure.fromJson(x))),
    details: json["details"],
    crew: List<dynamic>.from(json["crew"].map((x) => x)),
    ships: List<dynamic>.from(json["ships"].map((x) => x)),
    capsules: List<dynamic>.from(json["capsules"].map((x) => x)),
    payloads: List<String>.from(json["payloads"].map((x) => x)),
    launchpad: json["launchpad"],
    flightNumber: json["flight_number"],
    name: json["name"],
    dateUtc: DateTime.parse(json["date_utc"]),
    dateUnix: json["date_unix"],
    dateLocal: DateTime.parse(json["date_local"]),
    datePrecision: json["date_precision"],
    upcoming: json["upcoming"],
    cores: List<Core>.from(json["cores"].map((x) => Core.fromJson(x))),
    autoUpdate: json["auto_update"],
    tbd: json["tbd"],
    launchLibraryId: json["launch_library_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fairings": fairings.toJson(),
    "links": links.toJson(),
    "static_fire_date_utc": staticFireDateUtc.toIso8601String(),
    "static_fire_date_unix": staticFireDateUnix,
    "net": net,
    "window": window,
    "rocket": rocket,
    "success": success,
    "failures": List<dynamic>.from(failures.map((x) => x.toJson())),
    "details": details,
    "crew": List<dynamic>.from(crew.map((x) => x)),
    "ships": List<dynamic>.from(ships.map((x) => x)),
    "capsules": List<dynamic>.from(capsules.map((x) => x)),
    "payloads": List<dynamic>.from(payloads.map((x) => x)),
    "launchpad": launchpad,
    "flight_number": flightNumber,
    "name": name,
    "date_utc": dateUtc.toIso8601String(),
    "date_unix": dateUnix,
    "date_local": dateLocal.toIso8601String(),
    "date_precision": datePrecision,
    "upcoming": upcoming,
    "cores": List<dynamic>.from(cores.map((x) => x.toJson())),
    "auto_update": autoUpdate,
    "tbd": tbd,
    "launch_library_id": launchLibraryId,
    "id": id,
  };
}
