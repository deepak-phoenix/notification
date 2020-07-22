import 'package:flutter/material.dart';

import 'Secondary/Event.dart';
import 'Secondary/Utility.dart';

class GenerateList extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<GenerateList> {
// variables
  var data;
  var utility;
  List<Event> events = [];
  Widget returnWidget;

  @override
  Widget build(BuildContext context) {
    if (events.length == 0) {
      returnWidget = Center(child: CircularProgressIndicator());
      loadEvent().then((value) {
        setState(() {
          events = value;
          returnWidget = dataBuilder();
        });
      });
    }
    return returnWidget;
  }

  Widget dataBuilder() {
    utility = Utility();
    List<Event> upcomming = utility.upComming(events);
    List<Event> nextYear = utility.nextYear(events);
    return RefreshIndicator(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              pinned: true,
              forceElevated: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: utility.countDownBuilder(upcomming),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: utility.sliverStringBuilder("Up comming"),
            ),
            SliverList(
              delegate: utility.sliverListBuilder(upcomming),
            ),
            SliverList(
              delegate: utility.sliverStringBuilder("Next Year"),
            ),
            SliverList(
              delegate: utility.sliverListBuilder(nextYear),
            ),
          ],
        ),
        onRefresh: refresh);
  }

  Future<void> refresh() async {
    utility.writeToast("Updating..", context);
    setState(() {
      events.clear();
    });
  }
}
