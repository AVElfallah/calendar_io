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
    final height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      //  color: Colors.blue,
      height: height * 0.18,
      padding: const EdgeInsets.all(20),
      child: ListView(
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
                onPressed: () {},
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
    );
  }
}
