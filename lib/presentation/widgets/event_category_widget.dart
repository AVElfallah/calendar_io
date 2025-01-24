import 'package:flutter/material.dart';

import '../../core/utils/colors_helper.dart';
import '../../domain/entities/event_category.dart';

class EventCategoryChipWidget extends StatefulWidget {
  final EventCategory? category;
  final void Function(bool isSelected)? onSelectChange;
  final void Function()? onDelete;
  final bool isSelected;

  const EventCategoryChipWidget(
      {super.key,
      this.category,
      this.onSelectChange,
      this.onDelete,
      this.isSelected = false});

  @override
  State<EventCategoryChipWidget> createState() =>
      _EventCategoryChipWidgetState();
}

class _EventCategoryChipWidgetState extends State<EventCategoryChipWidget> {
  bool toggleDelete = false;

  @override
  Widget build(BuildContext context) {
    // to check color lim for text color to make it visible
    // if lim is dark text will be white
    // if lim is light text will be black
    final Color blendedColor = Color.alphaBlend(
        widget.category?.color?.withOpacity(.1) ??
            ColorsHelper.appMainColorPurple.withOpacity(.1),
        Colors.white);
    final colorLim = blendedColor.computeLuminance();
    return GestureDetector(
      onTap: () {
        widget.onSelectChange?.call(!widget.isSelected);
        setState(() {});
      },
      onLongPress: () {
        toggleDelete = !toggleDelete;
        setState(() {});
      },
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: widget.category?.color ?? Colors.green,
            width: widget.isSelected ? 3 : .5,
          ),
        ),
        onDeleted: toggleDelete
            ? () {
                widget.onDelete?.call();
              }
            : null,
        backgroundColor: widget.category?.color?.withOpacity(.1) ??
            ColorsHelper.appMainColorPurple.withOpacity(.1),
        avatar: CircleAvatar(
          backgroundColor:
              widget.category?.color ?? ColorsHelper.appMainColorPurple,
          foregroundColor: Colors.white,
          radius: 10,
          child: const CircleAvatar(
            radius: 4,
          ),
        ),
        label: Text(
          widget.category?.name ?? 'Brainstorm',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: (colorLim > 0.5) ? Colors.black : Colors.white,
              ),
        ),
      ),
    );
  }
}
