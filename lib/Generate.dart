import 'package:flutter/material.dart';

import 'package:notification/Event.dart';
import 'package:notification/IteamState.dart';

class GenerateList extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<GenerateList> {
  List<IteamState> _data = generateIteam(events.length);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: _buildPanel(),
      );

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      children: _data.map<ExpansionPanelRadio>((IteamState iteam) {
        var today = DateTime.now();
        return ExpansionPanelRadio(
          value: iteam.id,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(events[iteam.id].getName()),
              trailing: Icon(
                events[iteam.id].getIsBirthday()
                    ? Icons.cake
                    : Icons.local_florist,
                color: events[iteam.id].getEvenDate().month > today.month
                    ? Colors.red
                    : events[iteam.id].getEvenDate().month == today.month
                        ? events[iteam.id].getEvenDate().day >= today.day
                            ? Colors.red
                            : Colors.grey
                        : Colors.grey,
              ),
              subtitle: Text(iteam.expandedValue),
            );
          },
          body: ListTile(
            title: Text(events[iteam.id].getIsBirthday()
                ? "Happy birthday"
                : "Happy Annerversary"),
            subtitle: Text("Wishes from dp..."),
          ),
        );
      }).toList(),
    );
  }
}

List<IteamState> generateIteam(int noOfIteams) {
  return List.generate(
    noOfIteams,
    (int index) {
      return IteamState(
        index,
        events[index].getEvenDate().day.toString() +
            "/" +
            events[index].getEvenDate().month.toString(),
      );
    },
  );
}

final List<Event> events = [
  Event("Prakesh", DateTime(0, 1, 1), false, true),
  Event("Saritha", DateTime(0, 1, 25), false, true),
  Event("Manya", DateTime(0, 1, 31), false, true),
  Event("Nidhi", DateTime(0, 2, 1), false, true),
  Event("Chandrakala", DateTime(0, 2, 1), false, true),
  Event("Sowbhagyamma", DateTime(0, 2, 20), false, true),
  Event("Sahana", DateTime(0, 2, 24), false, true),
  Event("Aanya", DateTime(0, 3, 1), false, true),
  Event("Anusha", DateTime(1997, 3, 10), false, true),
  Event("Savitha", DateTime(0, 3, 14), false, true),
  Event("Mallik", DateTime(1959, 4, 5), false, true),
  Event("Siri", DateTime(0, 4, 15), false, true),
  Event("Sharvana", DateTime(0, 4, 18), false, true),
  Event("Jeevika", DateTime(2001, 4, 21), false, true),
  Event("Shivu", DateTime(0, 4, 30), false, true),
  Event("Vishala", DateTime(1972, 5, 5), false, true),
  Event("Sherya", DateTime(0, 5, 5), false, true),
  Event("Anusha & Nithin", DateTime(2020, 5, 13), true, false),
  Event("Chandrakala & Sadhashivaiah", DateTime(0, 5, 22), true, false),
  Event("Sahana & Vishwanath", DateTime(0, 5, 24), true, false),
  Event("Annapurana & Prakesh", DateTime(0, 5, 25), true, false),
  Event("Sowbhagya & Guru", DateTime(0, 5, 25), true, false),
  Event("Pavithra M", DateTime(0, 6, 3), false, true),
  Event("Nata", DateTime(0, 6, 5), false, true),
  Event("Sadhashivaiah", DateTime(0, 6, 10), false, true),
  Event("Annapurana", DateTime(0, 6, 12), false, true),
  Event("Vishwanath", DateTime(0, 6, 14), false, true),
  Event("Mohana", DateTime(0, 6, 19), false, true),
  Event("Saritha & Shivu", DateTime(0, 6, 18), true, false),
  Event("Jeevan", DateTime(2000, 7, 6), false, true),
  Event("Guru", DateTime(0, 7, 11), false, true),
  Event("Manjula", DateTime(0, 8, 22), false, true),
  Event("Muruli", DateTime(0, 8, 22), false, true),
  Event("Mohana & Pavithra M", DateTime(0, 8, 1), true, false),
  Event("Nithin", DateTime(0, 9, 14), false, true),
  Event("Raju", DateTime(0, 9, 24), false, true),
  Event("Chethan", DateTime(0, 10, 7), false, true),
  Event("Deepak", DateTime(1997, 10, 14), false, true),
  Event("Chinthan", DateTime(0, 10, 20), false, true),
  Event("Shipla", DateTime(0, 11, 12), false, true),
  Event("Yoganand", DateTime(0, 11, 19), false, true),
  Event("Nata & Pavithra N", DateTime(0, 11, 8), true, false),
  Event("Pavithra N", DateTime(0, 12, 2), false, true),
];
