import 'package:equatable/equatable.dart';

class Radio extends Equatable {
  const Radio({
    required this.name,
    required this.stationuuid,
    required this.url,
    required this.state,
    required this.tags,
    required this.language,
    required this.votes,
    required this.favicon,
  });

  final String? name;
  final String? stationuuid;
  final String? url;
  final String? state;
  final String? tags;
  final String? favicon;
  final String? language;
  final int? votes;

  factory Radio.fromJson(Map<String, dynamic> json) {
    return Radio(
      name: json["name"],
      stationuuid: json['stationuuid'],
      url: json["url"],
      tags: json['tags'],
      state: json['state'],
      language: json['language'],
      votes: json['votes'],
      favicon: json['favicon'] == "" ? null : json['favicon'],
    );
  }

  @override
  List<Object?> get props => [
        name,
        stationuuid,
        url,
        tags,
        state,
        language,
        votes,
        favicon
      ];
}
