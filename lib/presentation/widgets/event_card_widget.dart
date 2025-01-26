import 'package:calendar_io/domain/entities/event_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

import '../../app/extensions/string_extensions.dart';

class EventCardWidget extends ConsumerStatefulWidget {
  const EventCardWidget({
    super.key,
    this.note,
  });
  final EventNote? note;

  @override
  ConsumerState<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends ConsumerState<EventCardWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return AnimatedSize(

curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i = 0; i < widget.note!.categories!.length && i < 3; i++)
                  Container(
                    height: 18,
                    width: 18,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.note!.categories![i]!.color!,
                        width: 6,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  '${DateTimeConverter.fromTime(widget.note?.start!)} - ${DateTimeConverter.fromTime(widget.note?.end!)}',
                  style: Theme.of(context).textTheme.headlineSmall!,
                ),
                const Spacer(),
                IconButton(
        
                  onPressed: () {
                    final RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    final localPosition = renderBox.localToGlobal(Offset.zero);
                    final buttonSize = renderBox.size;
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          localPosition.dy,
                          localPosition.dy -
                              buttonSize.height / 2, // Position above
                          localPosition.dx -
                              buttonSize.width, // Center horizontally
                          localPosition.dx, // Set bottom boundary of the menu
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        items: [
                          PopupMenuItem(
                            child: const Text('Edit'),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: const Text('Delete'),
                            onTap: () {
                              
                            },
                          ),
                        ]);
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color(0xFF8F9BB3),
                  ),
                )
              ],
            ),
            SizedBox(
              width: width * 0.8,
              child: Text(
                widget.note?.name ?? 'Design new UX flow for Michael',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge!,
              ),
            ),
            ReadMoreText(
              widget.note?.note ?? 'Start from screen 16',
              style: const TextStyle(color: Color(0xFF8F9BB3)),
              trimLines: 1,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' read more',
              trimExpandedText: ' read less',
            ),
          ],
        ),
      ),
    );
  }
}
