import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

String relativePath = "assets/data.json";
String fullPath =
    "/Users/deepakpatel/Dev/weekends/notification/assets/data.json";
String dataSource = "https://deepak-phoenix.github.io/Phoenix/data.json";

class Event {
  String name;
  DateTime eventdate;
  bool isbirthday;

  Event({this.name = "No name", this.eventdate, this.isbirthday = true});

  String get getName => this.name;
  DateTime get getDate => this.eventdate;
  bool get getisBirthday => this.isbirthday;

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(
      name: parsedJson["Name"],
      eventdate:
          DateTime(parsedJson["Year"], parsedJson["Month"], parsedJson["Day"]),
      isbirthday: parsedJson["isBirthday"],
    );
  }
}

Future<String> loadEventLocal() async {
  return await rootBundle.loadString(relativePath);
}

Future<void> writeLocal(String content) async {
  print("Writing file");
  File(relativePath).writeAsString(content).then((value) => print("done"));
}

Future<String> loadEventRemote() async {
  var connection = await Connectivity().checkConnectivity();
  if (connection != ConnectivityResult.none) {
    final res = await http.get(dataSource);
    if (res.statusCode == 200) {
      // if (res.body != await loadEventLocal()) await writeLocal(res.body);
      return res.body;
    }
  }
  return loadEventLocal();
}

Future<List<Event>> loadEvent() async {
  List<Event> events = [];
  String jsonString = await loadEventRemote();
  final jsonResponse = json.decode(jsonString);
  for (var ele in jsonResponse) {
    events.add(Event.fromJson(ele));
  }
  return sortListEvent(events);
}

List<Event> sortListEvent(List<Event> eventForSort) {
  eventForSort.sort((a, b) {
    if (a.eventdate.month == b.eventdate.month)
      return a.eventdate.day.compareTo(b.eventdate.day);
    return a.eventdate.month.compareTo(b.eventdate.month);
  });
  return eventForSort;
}
