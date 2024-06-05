// To parse this JSON data, do
//
////final data = dataFromJson(jsonString);

import 'dart:convert';

List<Data> dataFromJson(String str) => List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
    Fairings fairings;
    Links links;
    DateTime staticFireDateUtc;
    int staticFireDateUnix;
    bool net;
    int window;
    String rocket;
    bool success;
    List<Failure> failures;
    String details;
    List<dynamic> crew;
    List<dynamic> ships;
    List<dynamic> capsules;
    List<String> payloads;
    String launchpad;
    int flightNumber;
    String name;
    DateTime dateUtc;
    int dateUnix;
    DateTime dateLocal;
    String datePrecision;
    bool upcoming;
    List<Core> cores;
    bool autoUpdate;
    bool tbd;
    dynamic launchLibraryId;
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

class Core {
    String core;
    int flight;
    bool gridfins;
    bool legs;
    bool reused;
    bool landingAttempt;
    dynamic landingSuccess;
    dynamic landingType;
    dynamic landpad;

    Core({
        required this.core,
        required this.flight,
        required this.gridfins,
        required this.legs,
        required this.reused,
        required this.landingAttempt,
        required this.landingSuccess,
        required this.landingType,
        required this.landpad,
    });

    factory Core.fromJson(Map<String, dynamic> json) => Core(
        core: json["core"],
        flight: json["flight"],
        gridfins: json["gridfins"],
        legs: json["legs"],
        reused: json["reused"],
        landingAttempt: json["landing_attempt"],
        landingSuccess: json["landing_success"],
        landingType: json["landing_type"],
        landpad: json["landpad"],
    );

    Map<String, dynamic> toJson() => {
        "core": core,
        "flight": flight,
        "gridfins": gridfins,
        "legs": legs,
        "reused": reused,
        "landing_attempt": landingAttempt,
        "landing_success": landingSuccess,
        "landing_type": landingType,
        "landpad": landpad,
    };
}

class Failure {
    int time;
    dynamic altitude;
    String reason;

    Failure({
        required this.time,
        required this.altitude,
        required this.reason,
    });

    factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        time: json["time"],
        altitude: json["altitude"],
        reason: json["reason"],
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "altitude": altitude,
        "reason": reason,
    };
}

class Fairings {
    bool reused;
    bool recoveryAttempt;
    bool recovered;
    List<dynamic> ships;

    Fairings({
        required this.reused,
        required this.recoveryAttempt,
        required this.recovered,
        required this.ships,
    });

    factory Fairings.fromJson(Map<String, dynamic> json) => Fairings(
        reused: json["reused"],
        recoveryAttempt: json["recovery_attempt"],
        recovered: json["recovered"],
        ships: List<dynamic>.from(json["ships"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "reused": reused,
        "recovery_attempt": recoveryAttempt,
        "recovered": recovered,
        "ships": List<dynamic>.from(ships.map((x) => x)),
    };
}

class Links {
    Patch patch;
    Reddit reddit;
    Flickr flickr;
    dynamic presskit;
    String webcast;
    String youtubeId;
    String article;
    String wikipedia;

    Links({
        required this.patch,
        required this.reddit,
        required this.flickr,
        required this.presskit,
        required this.webcast,
        required this.youtubeId,
        required this.article,
        required this.wikipedia,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        patch: Patch.fromJson(json["patch"]),
        reddit: Reddit.fromJson(json["reddit"]),
        flickr: Flickr.fromJson(json["flickr"]),
        presskit: json["presskit"],
        webcast: json["webcast"],
        youtubeId: json["youtube_id"],
        article: json["article"],
        wikipedia: json["wikipedia"],
    );

    Map<String, dynamic> toJson() => {
        "patch": patch.toJson(),
        "reddit": reddit.toJson(),
        "flickr": flickr.toJson(),
        "presskit": presskit,
        "webcast": webcast,
        "youtube_id": youtubeId,
        "article": article,
        "wikipedia": wikipedia,
    };
}

class Flickr {
    List<dynamic> small;
    List<dynamic> original;

    Flickr({
        required this.small,
        required this.original,
    });

    factory Flickr.fromJson(Map<String, dynamic> json) => Flickr(
        small: List<dynamic>.from(json["small"].map((x) => x)),
        original: List<dynamic>.from(json["original"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "small": List<dynamic>.from(small.map((x) => x)),
        "original": List<dynamic>.from(original.map((x) => x)),
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
        small: json["small"],
        large: json["large"],
    );

    Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
    };
}

class Reddit {
    dynamic campaign;
    dynamic launch;
    dynamic media;
    dynamic recovery;

    Reddit({
        required this.campaign,
        required this.launch,
        required this.media,
        required this.recovery,
    });

    factory Reddit.fromJson(Map<String, dynamic> json) => Reddit(
        campaign: json["campaign"],
        launch: json["launch"],
        media: json["media"],
        recovery: json["recovery"],
    );

    Map<String, dynamic> toJson() => {
        "campaign": campaign,
        "launch": launch,
        "media": media,
        "recovery": recovery,
    };
}
