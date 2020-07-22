import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'Event.dart';

// non-static functions

class Utility {
  var today;

  Utility() {
    today = DateTime.now();
  }

// This splits the whole events into the upcomming event
  List<Event> upComming(List<Event> events) {
    List<Event> returnEvent = [];
    events.forEach((element) {
      if (element.getDate.month > today.month ||
          (element.getDate.month == today.month &&
              element.getDate.day >= today.day)) {
        returnEvent.add(element);
      }
    });
    return returnEvent;
  }

// This splits the whole events into the next year event.
  List<Event> nextYear(List<Event> events) {
    List<Event> returnEvent = [];
    events.forEach((element) {
      if (element.getDate.month < today.month ||
          (element.getDate.month == today.month &&
              element.getDate.day < today.day)) {
        returnEvent.add(element);
      }
    });
    return returnEvent;
  }

  Widget countDownBuilder(List<Event> upcomming) {
    var returnString = '';
    var next = upcomming[0];
    var names = getNames(upcomming);
    var eventDate = DateTime(today.year, next.getDate.month, next.getDate.day);
    var numberOfDays = eventDate.difference(today);
    if (eventDate.compareTo(today) == 0)
      returnString = "Wish " + names + " today.";
    else
      returnString =
          "Wish " + names + " in " + numberOfDays.inDays.toString() + " Days.";
    return Text(
      returnString,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }

  String getNames(List<Event> upcomming) {
    List<String> namesList = [];
    var next = upcomming[0];
    var counter = 0;
    while (next.getDate.day == upcomming[counter].getDate.day &&
        next.getDate.month == upcomming[counter].getDate.month &&
        counter < upcomming.length) {
      namesList.add(upcomming[counter].getName);
      namesList.add("/");
      counter++;
    }
    var names = '';
    for (var i = 0; i < namesList.length - 1; i++) {
      names = names + namesList[i];
    }
    return names;
  }

  Widget ageBuilder(Event event) {
    var returnNumber;
    if (event.eventdate.year == 0) {
      returnNumber = 00;
    } else {
      returnNumber = today.difference(event.eventdate).inDays ~/ 365;
    }
    if (event.getisBirthday) {
      return ClipOval(
        child: Material(
          color: Colors.grey[350],
          child: SizedBox(
            child: Center(
                child: Icon(
              Icons.lock,
              color: Colors.black,
            )),
            width: 30.0,
            height: 30.0,
          ),
        ),
      );
    }
    return ClipOval(
      child: Material(
        color: !event.getisBirthday
            ? returnNumber > 20
                ? Color.fromRGBO(246, 224, 201, 100)
                : Colors.grey[350]
            : Colors.grey[350],
        child: SizedBox(
          child: Center(
            child: Text(
              returnNumber.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          width: 30.0,
          height: 30.0,
        ),
      ),
    );
  }

  // This builds a sliver list for events
  SliverChildDelegate sliverListBuilder(List<Event> funEvent) =>
      SliverChildBuilderDelegate(
        (context, index) {
          if (index.isOdd)
            return Divider(
              endIndent: 20,
              indent: 20,
            );
          var i = index ~/ 2;
          return Container(
            child: ListTile(
              leading: ageBuilder(funEvent[i]),
              title: Text(
                funEvent[i].getName,
                style: TextStyle(fontSize: 18.0),
              ),
              trailing: Icon(
                funEvent[i].getisBirthday ? Icons.cake : Icons.favorite,
                color: Colors.red,
              ),
              subtitle: Text(
                funEvent[i].getisBirthday
                    ? funEvent[i].getDate.day.toString() +
                        "/" +
                        funEvent[i].getDate.month.toString()
                    : funEvent[i].getDate.year == 0
                        ? funEvent[i].getDate.day.toString() +
                            "/" +
                            funEvent[i].getDate.month.toString()
                        : funEvent[i].getDate.day.toString() +
                            "/" +
                            funEvent[i].getDate.month.toString() +
                            "/" +
                            funEvent[i].getDate.year.toString(),
              ),
            ),
          );
        },
        childCount: funEvent.length * 2,
      );

// This build a text in the middle of the sliver list.
  SliverChildListDelegate sliverStringBuilder(String message) =>
      SliverChildListDelegate.fixed([
        ListTile(
          title: Text(
            message,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Divider(
          color: Colors.grey,
          endIndent: 30.0,
          indent: 30.0,
        )
      ]);

  void writeToast(String msg, BuildContext context) => Toast.show(msg, context,
      backgroundColor: Colors.black12,
      textColor: Colors.black,
      border: Border.all(color: Colors.black26, width: 0.5));
}
