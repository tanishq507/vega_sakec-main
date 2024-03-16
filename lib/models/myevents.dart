import 'package:cloud_firestore/cloud_firestore.dart';

class myEvents {
  String title;
  String description;
  String location;
  Timestamp datetime;
  bool isLive;
  String owner;

  myEvents(
      {required this.title,
      required this.description,
      required this.location,
      required this.datetime,
      required this.isLive,
      required this.owner});

  myEvents.fromJson(
    Map<String, dynamic> json,
  )   : title = json['title']! as String,
        description = json['description']! as String,
        location = json['location']! as String,
        datetime = json['datetime']! as Timestamp,
        isLive = json['isLive']! as bool,
        owner = json['owner']! as String;

  copyWith(
      {String? title,
      String? description,
      String? location,
      Timestamp? datetime,
      bool? isLive,
      String? owner}) {
    return myEvents(
        title: title ?? this.title,
        description: description ?? this.description,
        location: location ?? this.location,
        datetime: datetime ?? this.datetime,
        isLive: isLive ?? this.isLive,
        owner: owner ?? this.owner);
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'datetime': datetime,
      'isLive': isLive,
      'owner': owner
    };
  }
}
