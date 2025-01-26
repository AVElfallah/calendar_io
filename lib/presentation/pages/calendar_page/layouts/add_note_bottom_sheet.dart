import 'package:calendar_io/core/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:calendar_io/app/extensions/input_decoration_extensions.dart';
import 'package:calendar_io/app/extensions/context_extensions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import '../../../controllers/event_note_controller.dart';
import '../../../widgets/event_category_widget.dart';
/// A widget that displays a bottom sheet for adding a new event note.
/// 
/// This widget uses the `ConsumerWidget` from the Riverpod package to watch
/// and interact with the `eventNoteController` provider.
/// 
/// The bottom sheet contains various input fields for event details such as
/// event name, note, date, start time, end time, and category. It also includes
/// a switch to set a reminder and a button to create the event.
/// 
/// The layout and design of the bottom sheet include:
/// - A title at the top.
/// - TextFormFields for event name, note, date, start time, and end time.
/// - A switch to toggle reminders.
/// - A section to select or add a new category.
/// - A button to create the event.
/// 
/// The widget handles user interactions such as showing date and time pickers,
/// toggling reminders, selecting categories, and adding new categories.
/// 
/// The `watchProvider` is used to manage the state and actions related to the
/// event note, such as setting the date, start time, end time, toggling reminders,
/// and adding the event note.

class AddNoteBottomSheet extends ConsumerWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = context.height;
    final watchProvider = ref.watch(eventNoteController);
    return Container(
      height: height * .55,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.1,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // [start] Title
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Center(
              child: Text(
                'Add New Event',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          // [end] Title
          Form(
            key: watchProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  // [start] Event Name Input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: watchProvider.validateName,
                      controller: watchProvider.eventNameController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const IDecorationWithHintText(
                        'Event Name',
                      ),
                    ),
                  ),
                  // [end] Event Name Input
                  // [start] Event Note Input
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextFormField(
                      controller: watchProvider.eventNoteController,
                      validator: watchProvider.validateName,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration:
                          const IDecorationWithHintText('Type the note here...'),
                    ),
                  ),
                  // [end] Event Note Input
                  // [start] Event Date Input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: watchProvider.eventDateController,
                      validator: watchProvider.validateDate,
                      style: Theme.of(context).textTheme.bodyMedium,
                      readOnly: true,
                      decoration: IDecorationWithHintText(
                        'Date',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.calendarOnly,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2300),
                            ).then((value) {
                              watchProvider.setDate(value!);
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  // [end] Event Date Input
                  // [start] Event Time Input
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: watchProvider.eventStartTimeController,
                            validator: watchProvider.validateStartTime,
                            style: Theme.of(context).textTheme.bodyMedium,
                            readOnly: true,
                            decoration: IDecorationWithHintText(
                              'Start Time',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    watchProvider.setStartTime(value!);
                                  });
                                },
                                icon: const Icon(Icons.timer_outlined),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: watchProvider.eventEndTimeController,
                            validator: watchProvider.validateEndTime,
                            style: Theme.of(context).textTheme.bodyMedium,
                            readOnly: true,
                            decoration: IDecorationWithHintText(
                              'End Time',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    watchProvider.setEndTime(value!);
                                  });
                                },
                                icon: const Icon(Icons.timer_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // [end] Event Time Input
                  // [start] Reminder Switch
                  SwitchListTile.adaptive(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    value: watchProvider.isReminder,
                    onChanged: watchProvider.toggleReminder,
                    title: Text(
                      'Reminds me',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  // [end] Reminder Switch
                  // [start] Category Section Title
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        'Select Category',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  // [end] Category Section Title
                  // [start] Category Chips
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        for (var category in watchProvider.categories)
                          EventCategoryChipWidget(
                            category: category,
                            isSelected: watchProvider.selectedCategories
                                .contains(category),
                            onSelectChange: (isSelected) {
                              if (isSelected) {
                                watchProvider.addSelectedCategory(category);
                              } else {
                                watchProvider.removeSelectedCategory(category);
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                  // [end] Category Chips
                  // [start] Add Category Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          watchProvider.toggleAddCategoryVisibility();
                        },
                        label: watchProvider.isAddCategory
                            ? const Text('Cancel')
                            : const Text('Add new'),
                        icon: watchProvider.isAddCategory
                            ? const Icon(Icons.cancel)
                            : const Icon(Icons.add),
                      ),
                    ),
                  ),
                  // [end] Add Category Button
                  // [start] Add Category Input
                  Visibility(
                    visible: watchProvider.isAddCategory,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ColorPicker(
                                color: watchProvider.categoryColor,
                                onColorChanged: watchProvider.changeCategoryColor,
                                pickersEnabled: const {
                                  ColorPickerType.both: false,
                                  ColorPickerType.primary: false,
                                  ColorPickerType.accent: true,
                                  ColorPickerType.bw: false,
                                  ColorPickerType.custom: false,
                                  ColorPickerType.wheel: false,
                                },
                              ).showPickerDialog(
                                context,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: watchProvider.categoryColor,
                              radius: 20,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.width * .75,
                            child: TextFormField(
                              controller:
                                  watchProvider.eventCategoryNameController,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: IDecorationWithHintText(
                                'Category Type Name here...',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    watchProvider.addCategory();
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    color: ColorsHelper.appMainColorPurple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // [end] Add Category Input
                  // [start] Create Event Button
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        watchProvider.addEventNote(
                          onSuccess: () {
                              Navigator.pop(context);
                            },
                            onFail: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                  content: Text('Something went wrong'),
                                ),
                              );
                            },
                        );
                       
                      },
                      child: const Text('Create Event'),
                    ),
                  ),
                  // [end] Create Event Button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
