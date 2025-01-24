import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventNote extends Equatable {
  final String? id;
  final String? name;
  final String? note;
  final DateTime? date;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final List<String?>? categoriesIDs;

  const EventNote(
      {this.id,
      this.name,
      this.date,
      this.note,
      this.end,
      this.start,
      this.categoriesIDs});

  @override
  List<Object?> get props => [id, name, date, note, end, start, categoriesIDs];
}
