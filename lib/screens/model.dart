// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';



class Launch {
  final int flightNumber;
  final String missionName;
  final String launchYear;
  final String missionPatch;
  final DateTime launchDate;
  final String details;
  final bool launchSuccess;
  final String articleLink;
  final String videoLink;

  Launch({
    required this.flightNumber,
    required this.missionName,
    required this.launchYear,
    required this.missionPatch,
    required this.launchDate,
    required this.details,
    required this.launchSuccess,
    required this.articleLink,
    required this.videoLink,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      flightNumber: json['flight_number'],
      missionName: json['mission_name'],
      launchYear: json['launch_year'],
      missionPatch: json['links']['mission_patch'] ?? '',
      launchDate: DateTime.parse(json['launch_date_utc']),
      details: json['details'] ?? 'No details available',
      launchSuccess: json['launch_success'] ?? false,
      articleLink: json['links']['article_link'] ?? '',
      videoLink: json['links']['video_link'] ?? '',
    );
  }
}


class Mission {
  final String missionName;
  final String missionId;
  final List<String> manufacturers;
  final List<String> payloadIds;
  final String wikipedia;
  final String website;
  final String? twitter;
  final String description;

  Mission({
    required this.missionName,
    required this.missionId,
    required this.manufacturers,
    required this.payloadIds,
    required this.wikipedia,
    required this.website,
    required this.twitter,
    required this.description,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionName: json['mission_name'],
      missionId: json['mission_id'],
      manufacturers: List<String>.from(json['manufacturers']),
      payloadIds: List<String>.from(json['payload_ids']),
      wikipedia: json['wikipedia'],
      website: json['website'],
      twitter: json['twitter'],
      description: json['description'],
    );
  }
}
