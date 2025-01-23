import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({
    super.key,
  });

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
              Container(
                height: 18,
                width: 18,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.cyan,
                    width: 6,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                '10:00-13:00',
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
              'Design new UX flow for Michael',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineLarge!,
            ),
          ),
          const ReadMoreText(
            'Start from screen 16',
            style: TextStyle(color: Color(0xFF8F9BB3)),
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
