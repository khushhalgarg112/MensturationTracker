import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:intl/intl.dart';

import '../db/period_data_model.dart';

const periodDataBox = 'periodDataBox';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Periods added'),
        ),
        body: const PeriodHistoryList());
  }
}

//*********** History: history tab ***********
class PeriodHistoryList extends StatefulWidget {
  const PeriodHistoryList({Key? key}) : super(key: key);

  @override
  State<PeriodHistoryList> createState() => _PeriodHistoryListState();
}

class _PeriodHistoryListState extends State<PeriodHistoryList> {
  @override
  Widget build(BuildContext context) {
    // ************ list building *************
    Widget _buildListView() {
      return ValueListenableBuilder(
          valueListenable: Hive.box<PeriodData>(periodDataBox).listenable(),
          builder: (context, Box<PeriodData> box1, _) {
            if (box1.values.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            }
            return ListView.builder(
              itemCount: box1.values.length,
              itemBuilder: (context, index) {
                PeriodData currentPData = box1.getAt(index)!;
                // print(currentPData.symptoms[0]);
                int count = 0;
                List item = [0, 1, 2, 3, 4, 5];
                for (int i in item) {
                  currentPData.symptoms[i] == false ? count : count++;
                }
                return Container(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 8, bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green.shade100.withAlpha(100),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.bloodtype_sharp,
                          color: Colors.redAccent.withAlpha(200),
                        ),
                        title: Text(
                            DateFormat.yMMMd()
                                .format(currentPData.periodDate)
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        subtitle: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 250,
                                    child: Text(
                                      currentPData.note,
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 19,
                          ),
                          Container(
                            child: count > 0
                                ? const Text(
                                    'Symptoms',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                : Text(''),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: currentPData.symptoms[0] == true
                                    ? Text('Cramps')
                                    : null,
                              ),
                              Container(
                                child: currentPData.symptoms[1] == true
                                    ? Text('Breakouts')
                                    : null,
                              ),
                              Container(
                                child: currentPData.symptoms[2] == true
                                    ? Text('TenderBreats')
                                    : null,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: currentPData.symptoms[3] == true
                                    ? Text('Fatigue')
                                    : null,
                              ),
                              Container(
                                child: currentPData.symptoms[4] == true
                                    ? Text('Bloating')
                                    : null,
                              ),
                              Container(
                                child: currentPData.symptoms[5] == true
                                    ? Text('Headache')
                                    : null,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Flow: ${currentPData.flow.toString()}',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete data ?'),
                                  content: Text(
                                      'Are you sure to delete data of ${DateFormat.yMMMd().format(currentPData.periodDate).toString()}'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');

                                        box1.deleteAt(index);
                                      },
                                      child: const Text('OK',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          });
    }

    return Column(
      children: <Widget>[Expanded(child: _buildListView())],
    );
  }
}
