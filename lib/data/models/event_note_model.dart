import 'package:calendar_io/app/extensions/string_extensions.dart';
import 'package:calendar_io/domain/entities/event_note.dart';

class EventNoteModel extends EventNote {
  // This is a DTO class to carrying data throw the app layers

  final String? eventID;
  final String? eventName;
  final String? eventNote;
  final String? eventDate;
  final String? eventStartTime;
  final String? eventEndTime;
  final List<String?>? eventCategoriesIDs;

  EventNoteModel({
    this.eventID,
    this.eventName,
    this.eventNote,
    this.eventDate,
    this.eventStartTime,
    this.eventEndTime,
    this.eventCategoriesIDs,
  }) : super(
          categoriesIDs: eventCategoriesIDs,
          id: eventID,
          name: eventName,
          note: eventNote,
          date: eventDate?.toDate(),
        );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'eventID': eventID,
      'eventName': eventName,
      'eventNote': eventNote,
      'eventDate': eventDate,
      'eventStartTime': eventStartTime,
      'eventEndTime': eventEndTime,
      'eventCategoriesIDs': eventCategoriesIDs,
    };
  }

  factory EventNoteModel.fromJson(Map<String, dynamic> map) {
    return EventNoteModel(
      eventID: map['eventID'] as String,
      eventName: map['eventName'] as String,
      eventNote: map['eventNote'] as String,
      eventDate: map['eventDate'] as String,
      eventStartTime: map['eventStartTime'] as String,
      eventEndTime: map['eventEndTime'] as String,
      eventCategoriesIDs: map['eventCategoriesIDs'],
    );
  }

  factory EventNoteModel.fromEventNote(EventNote note) {
    return EventNoteModel(
      eventID: note.id,
      eventName: note.name,
      eventNote: note.note,
      eventDate: DateTimeConverter.fromDate(note.date),
      eventStartTime: DateTimeConverter.fromTime(note.start), // note.startTime,
      eventEndTime: DateTimeConverter.fromTime(note.end),
      eventCategoriesIDs: note.categoriesIDs,
    );
  }

  EventNote toEventNote() => EventNote(
        id: eventID,
        name: eventName,
        note: eventNote,
        date: eventDate?.toDate(),
        start: eventStartTime?.toTime(),
        end: eventEndTime?.toTime(),
        categoriesIDs: eventCategoriesIDs,
      );

  EventNoteModel copyWith({
    String? eventID,
    String? eventName,
    String? eventNote,
    String? eventDate,
    String? eventStartTime,
    String? eventEndTime,
    List<String?>? eventCategoriesIDs,
  }) {
    return EventNoteModel(
      eventID: eventID ?? this.eventID,
      eventName: eventName ?? this.eventName,
      eventNote: eventNote ?? this.eventNote,
      eventDate: eventDate ?? this.eventDate,
      eventStartTime: eventStartTime ?? this.eventStartTime,
      eventEndTime: eventEndTime ?? this.eventEndTime,
      eventCategoriesIDs: eventCategoriesIDs ?? this.eventCategoriesIDs,
    );
  }
}
