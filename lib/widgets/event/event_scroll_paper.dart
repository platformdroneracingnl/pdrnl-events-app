import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/event.dart';

class EventScrollPaper extends StatelessWidget {
  final Event event;

  const EventScrollPaper({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
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
              style: Styles.headLineStyle1,
            ),
            const SizedBox(height: 10),
            Text(
              DateFormat('dd-MM-yyyy').format(event.date),
              style: Styles.headLineStyle4,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://petapixel.com/assets/uploads/2022/07/DALLEcopy.jpg'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Organization',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: const Icon(
                        Icons.euro,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      event.price,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
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
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                eventFact(context, event.location.name),
                eventFact(context,
                    'Start registration: ${DateFormat('dd-MM-yyyy').format(event.startRegistration)}'),
                eventFact(context,
                    'End Registration: ${DateFormat('dd-MM-yyyy').format(event.endRegistration)}'),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(height: 4),
            ),
            Text("More info", style: Theme.of(context).textTheme.headline6),
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

  Widget eventFact(BuildContext context, detail) {
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
            detail,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
