import 'dart:convert';

import 'package:flutter/foundation.dart';

class Events {
  List<Event>? events;
  Events({
    this.events,
  });

  Events copyWith({
    List<Event>? events,
  }) {
    return Events(
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'events': events!.map((x) => x.toMap()).toList(),
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      events: List<Event>.from(map['events']?.map((x) => Event.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source));

  idGenerator(details) {
    return '${details.planName}${details.exercises?[0].id}${details.exercises?[0].id}';
  }
}

class Event {
  final String? id;
  final List<DateTime>? dateTime;
  final int? exercisesRepetations;
  final int? exercisesWeight;

  Event({
    this.id,
    this.dateTime,
    this.exercisesRepetations,
    this.exercisesWeight,
  });

  @override
  String toString() {
    return 'Event(id: $id, dateTime: $dateTime, exercisesRepetations: $exercisesRepetations, exercisesWeight: $exercisesWeight)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime!.map((x) => x.millisecondsSinceEpoch).toList(),
      'exercisesRepetations': exercisesRepetations,
      'exercisesWeight': exercisesWeight,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      dateTime: List<DateTime>.from(
          map['dateTime']?.map((x) => DateTime.fromMillisecondsSinceEpoch(x))),
      exercisesRepetations: map['exercisesRepetations']?.toInt(),
      exercisesWeight: map['exercisesWeight']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        listEquals(other.dateTime, dateTime) &&
        other.exercisesRepetations == exercisesRepetations &&
        other.exercisesWeight == exercisesWeight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateTime.hashCode ^
        exercisesRepetations.hashCode ^
        exercisesWeight.hashCode;
  }

  Event copyWith({
    String? id,
    List<DateTime>? dateTime,
    int? exercisesRepetations,
    int? exercisesWeight,
  }) {
    return Event(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      exercisesRepetations: exercisesRepetations ?? this.exercisesRepetations,
      exercisesWeight: exercisesWeight ?? this.exercisesWeight,
    );
  }
}
