import 'package:flutter/material.dart';
import 'Event.dart';

// non-static functions

class Utility {
  final today = DateTime.now();

// This splits the whole events into the upcomming event
  List<Event> upComming(List<Event> events) {
    List<Event> returnEvent = [];
    events.forEach((element) {
      if (element.getEvenDate().month > today.month ||
          (element.getEvenDate().month == today.month &&
              element.getEvenDate().day >= today.day)) {
        returnEvent.add(element);
      }
    });
    return returnEvent;
  }

// This splits the whole events into the next year event.
  List<Event> nextYear(List<Event> events) {
    List<Event> returnEvent = [];
    events.forEach((element) {
      if (element.getEvenDate().month < today.month ||
          (element.getEvenDate().month == today.month &&
              element.getEvenDate().day < today.day)) {
        returnEvent.add(element);
      }
    });
    return returnEvent;
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
