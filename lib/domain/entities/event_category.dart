// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventCategory extends Equatable {
  final String? id;
  final String? name;
  final Color? color;
  const EventCategory({
    this.id,
    this.name,
    this.color,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        color,
      ];
}
