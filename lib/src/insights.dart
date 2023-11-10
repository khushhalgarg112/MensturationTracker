import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import '../classes/graph.dart';
import '../db/period_data_model.dart';

const periodDataBox = 'periodDataBox';

class Insights extends StatefulWidget {
  const Insights({Key? key}) : super(key: key);

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    // ************ list building *************
    List<periodGraph> listData = [];

    Widget _buildListView1() {
      return ValueListenableBuilder(
        valueListenable: Hive.box<PeriodData>(periodDataBox).listenable(),
        builder: (context, Box<PeriodData> box1, _) {
          if (box1.values.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          }
          int i = 0;

          if (box1.values.length > 3) {
            i = box1.values.length - 3;
          }
          while (i < box1.values.length) {
            PeriodData currentPData = box1.getAt(i)!;
            listData.add(periodGraph(
                date: DateFormat.yMMMd()
                    .format(currentPData.periodDate)
                    .toString(),
                flow: currentPData.flow));

            i++;
          }

          List<charts.Series<periodGraph, String>> timeline = [
            charts.Series(
              id: "Subscribers",
              data: listData,
              domainFn: (periodGraph timeline, _) => timeline.date,
              measureFn: (periodGraph timeline, _) => timeline.flow,
            )
          ];
          return Center(
              child: Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Date and flow chart ",
                    ),
                    Expanded(
                      child: charts.BarChart(timeline, animate: true),
                    ),
                    const Text(
                      "“Source: Live Data”",
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _buildListView1(),
        ),
      ),
    );
  }
}

// Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Work in Progress....',
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.bold,
//                   )),
//               Icon(
//                 Icons.handyman_outlined,
//                 color: Colors.grey.shade500,
//               )
//             ],
//           ),
//         // )