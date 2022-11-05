import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pdrnl_events_app/models/event.dart';

class EventScrollPaper extends StatelessWidget {
  final LocalEvent event;

  const EventScrollPaper({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 5,
                        width: 50,
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),
                Text(
                  event.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormat('dd-MM-yyyy').format(event.date),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://petapixel.com/assets/uploads/2022/07/DALLEcopy.jpg'),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Organisation",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.euro,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Price",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 4),
                ),
                Text(
                  "Information",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                Text(
                  'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black54),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 4),
                ),
                Text(
                  "Event facts",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                // TODO: Add event facts
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => eventFacts(context),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 4),
                ),
                Text("Steps", style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => steps(context, index),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget steps(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 12,
            child: Text("${index + 1}"),
          ),
          Column(
            children: [
              SizedBox(
                width: 270,
                child: Text(
                  "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 155,
                width: 270,
                child: Image.network(
                    'https://petapixel.com/assets/uploads/2022/07/DALLEcopy.jpg'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget eventFacts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xFFE3FFF8),
            child: Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: Color(0xFF00C853),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Start/End time",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
