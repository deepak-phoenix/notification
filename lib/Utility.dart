import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'Event.dart';

// non-static functions

class Utility {
  var _today = DateTime.now();

// This splits the whole events into the upcomming event
  List<Event> upComming(List<Event> events) {
    List<Event> returnEvent = [];
    events.forEach((element) {
      if (element.getEvenDate().month > _today.month ||
          (element.getEvenDate().month == _today.month &&
              element.getEvenDate().day >= _today.day)) {
        returnEvent.add(element);
      }
    });
    return returnEvent;
  }

// This splits the whole events into the next year event.
  List<Event> nextYear(List<Event> events) {
    List<Event> returnEvent = [];
    events.forEach((element) {
      if (element.getEvenDate().month < _today.month ||
          (element.getEvenDate().month == _today.month &&
              element.getEvenDate().day < _today.day)) {
        returnEvent.add(element);
      }
    });
    return returnEvent;
  }

  Widget countDownBuilder(Event next) {
    var returnString = '';
    var eventDate =
        DateTime(_today.year, next.getEvenDate().month, next.getEvenDate().day);
    var numberOfDays = eventDate.difference(_today);
    if (eventDate.compareTo(_today) == 0)
      returnString = "Wish " + next.getName() + " today.";
    else
      returnString = "Wish " +
          next.getName() +
          " in " +
          numberOfDays.inDays.toString() +
          " Days.";
    return Center(
      child: Text(
        returnString,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

// static functions

// This builds a sliver list for events
SliverChildDelegate sliverListBuilder(List<Event> funEvent) =>
    SliverChildBuilderDelegate(
      (context, index) {
        if (index.isOdd) return Divider();
        var i = index ~/ 2;
        return Container(
          child: ListTile(
            title: Text(
              funEvent[i].getName(),
              style: TextStyle(fontSize: 18.0),
            ),
            trailing: Icon(
              funEvent[i].getIsBirthday() ? Icons.cake : Icons.local_florist,
              color: Colors.red,
            ),
            subtitle: Text(funEvent[i].getEvenDate().year == 0
                ? funEvent[i].getEvenDate().day.toString() +
                    "/" +
                    funEvent[i].getEvenDate().month.toString()
                : funEvent[i].getEvenDate().day.toString() +
                    "/" +
                    funEvent[i].getEvenDate().month.toString() +
                    "/" +
                    funEvent[i].getEvenDate().year.toString()),
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
      )
    ]);

void writeToast(String msg, BuildContext context) => Toast.show(msg, context,
    backgroundColor: Colors.black12,
    textColor: Colors.black,
    border: Border.all(color: Colors.black26, width: 0.5));
