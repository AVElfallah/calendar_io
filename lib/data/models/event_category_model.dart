// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calendar_io/app/extensions/string_extensions.dart';
import 'package:calendar_io/domain/entities/event_category.dart';

class EventCategoryModel extends EventCategory {
  final String? categoryID;
  final String? categoryName;
  final String? categoryColor;
  EventCategoryModel({
    this.categoryID,
    this.categoryName,
    this.categoryColor,
  }) : super(
            id: categoryID,
            color: categoryColor?.toColor(),
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
      categoryColor: ColorStringExtension.fromColor(eventCategory.color!),
    );
  }

  EventCategory toEventCategory() => EventCategory(
        id: categoryID,
        color: categoryColor?.toColor(),
        name: categoryName,
      );

  EventCategoryModel copyWith({
    String? categoryID,
    String? categoryName,
    String? categoryColor,
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
