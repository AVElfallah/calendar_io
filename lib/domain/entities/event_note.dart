import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'event_category.dart';

class EventNote extends Equatable {
  final String? id;
  final String? name;
  final String? note;
  final DateTime? date;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final List<EventCategory?>? categories;

  const EventNote(
      {this.id,
      this.name,
      this.date,
      this.note,
      this.end,
      this.start,
      this.categories});

  @override
  List<Object?> get props => [id, name, date, note, end, start, categories];
}
