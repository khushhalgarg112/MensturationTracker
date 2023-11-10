import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'db/period_data_model.dart';
import 'src/history.dart';
import 'form/add_form.dart';
import 'src/home.dart';
import 'colors.dart';
import 'src/insights.dart';
import 'src/info.dart';

/*
-------- SANA ALPHA v1 --------

Options:
  // done - Add a day: floating navigation button
  Home: appbar with calendar, details and few banners
  // done - History: Cards of added details
  Insights: Details from added data
  Info: About the app and credits

Other things:
  Intro to the app slides
  Cool transitions

*/

// boxname
const periodDataBox = 'periodDataBox';

void main() async {
   
  await Hive.initFlutter();

  Hive.registerAdapter<PeriodData>(PeriodDataAdapter());
 
  await Hive.openBox<PeriodData>(periodDataBox);
  runApp( MyApp());
}

//*********** MyApp: Base material app ***********
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sana',
      home: const BaseApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green.shade400,
            secondary: SanaColors.secondaryPink
          ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: SanaColors.darkColor),
        ),
      ),
    );
  }
}

//*********** BaseApp: Base Scaffold for the app ***********
class BaseApp extends StatefulWidget {
  const BaseApp({ Key? key }) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {

  //final box = Hive.box(periodDataBox);

  // BottomNavigationBar functions
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }


  // navigation options
final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    /* History */
    const History(),
    const Insights(),
    const Information(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* body */
      body: _widgetOptions.elementAt(_selectedIndex),
      /* FloatingActionButton */
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 30,),
        backgroundColor: Colors.green.shade400,
        onPressed: () {
          // open form for adding data
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPeriod()));
        },
      ),
      /* BottomNavigation */
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Colors.white,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: SanaColors.darkColor,
        unselectedItemColor: const Color(0xa9442c2e),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: SanaColors.secondaryPink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: 'Data',
            backgroundColor: SanaColors.secondaryPink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Insights',
            backgroundColor: SanaColors.secondaryPink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Information',
            backgroundColor: SanaColors.secondaryPink,
          ),
        ],
        ),
    );
  }
}

