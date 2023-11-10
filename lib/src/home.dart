import 'package:flutter/material.dart';
import '../edited_packages/calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

DateTime selectedDate = DateTime.now();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        fullCalendar: false,
        backButton: false,
        onDateChanged: (value) {},
        lastDate: DateTime.now(),
      ),
      body: HomeBody(),
    );
  }
}

//*********** HomeBody: It contains slider and more details ***********

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Insights',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Get Insights\nof you menstruation\ncycles with.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Work in progress....',
                style: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.bold)),
            Icon(
              Icons.handyman_outlined,
              color: Colors.grey.shade500,
            )
          ],
        )
      ],
    );
  }
}
