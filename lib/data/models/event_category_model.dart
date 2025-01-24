import 'package:calendar_io/domain/entities/event_category.dart';
import 'package:flutter/material.dart';

class EventCategoryModel extends EventCategory {
  final String? categoryID;
  final String? categoryName;
  final int? categoryColor;
  EventCategoryModel({
    this.categoryID,
    this.categoryName,
    this.categoryColor,
  }) : super(
            id: categoryID,
            color: Color(categoryColor ?? 0),
            name: categoryName);

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
      categoryID: json['categoryID'],
      categoryName: json['categoryName'],
      categoryColor: json['categoryColor'],
    );
  }

  factory EventCategoryModel.fromEventCategory(EventCategory eventCategory) {
    return EventCategoryModel(
      categoryID: eventCategory.id,
      categoryName: eventCategory.name,
      categoryColor: eventCategory.color?.value,
    );
  }

  EventCategory toEventCategory() => EventCategory(
        id: categoryID,
        color: Color(categoryColor ?? 0),
        name: categoryName,
      );

  EventCategoryModel copyWith({
    String? categoryID,
    String? categoryName,
    int? categoryColor,
  }) {
    return EventCategoryModel(
      categoryID: categoryID ?? this.categoryID,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryColor': categoryColor,
        'categoryID': categoryID,
        "categoryName": categoryName,
      };
}
