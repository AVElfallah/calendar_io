import 'package:calendar_io/core/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:calendar_io/app/extensions/input_decoration_extensions.dart';
import 'package:calendar_io/app/extensions/context_extensions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import '../controllers/event_note_controller.dart';
import '../widgets/event_category_widget.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Center(
              child: Text(
                'Add New Event',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: watchProvider.eventNameController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const IDecorationWithHintText(
                      'Event Name',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller: watchProvider.eventNoteController,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration:
                        const IDecorationWithHintText('Type the note here...'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: watchProvider.eventDateController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    readOnly: true,
                    decoration: IDecorationWithHintText(
                      'Date',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: watchProvider.eventStartTimeController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          readOnly: true,
                          decoration: IDecorationWithHintText(
                            'Start Time',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.timer_outlined),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          readOnly: true,
                          decoration: IDecorationWithHintText(
                            'End Time',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.timer_outlined),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  value: watchProvider.isReminder,
                  onChanged: watchProvider.toggleReminder,
                  title: Text(
                    'Reminds me',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Create Event'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
