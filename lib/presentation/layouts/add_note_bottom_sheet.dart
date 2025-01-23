import 'package:calendar_io/core/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:calendar_io/app/extensions/input_decoration_extensions.dart';
import 'package:calendar_io/app/extensions/context_extensions.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;

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
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration:
                        const IDecorationWithHintText('Type the note here...'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
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
                  value: true,
                  onChanged: (v) {},
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Chip(
                        backgroundColor: const Color.fromARGB(7, 116, 91, 242),
                        avatar: const CircleAvatar(
                          backgroundColor: ColorsHelper.appMainColorPurple,
                          foregroundColor: Colors.white,
                          radius: 10,
                          child: CircleAvatar(
                            radius: 4,
                          ),
                        ),
                        label: Text(
                          'Brainstorm',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const Chip(
                        backgroundColor: Color.fromARGB(28, 0, 179, 131),
                        avatar: CircleAvatar(
                          backgroundColor: Color(0xff00B383),
                          foregroundColor: Colors.white,
                          radius: 10,
                          child: CircleAvatar(
                            radius: 4,
                          ),
                        ),
                        label: Text('Design'),
                      ),
                      const Chip(
                        backgroundColor: Color.fromARGB(28, 0, 149, 255),
                        avatar: CircleAvatar(
                          backgroundColor: Color(0xff0095FF),
                          foregroundColor: Colors.white,
                          radius: 10,
                          child: CircleAvatar(
                            radius: 4,
                          ),
                        ),
                        label: Text('Workout'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextButton.icon(
                        onPressed: () {},
                        label: const Text('Add new'),
                        icon: const Icon(Icons.add)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF735BF2),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, height * .06),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
