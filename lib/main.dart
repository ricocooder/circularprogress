import 'dart:math';
import 'dart:ui';

import 'package:circularprogress/radial_progres_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
double fontsize = 20.0;
int preferencesTest = 0;
int testInt = 0;
var timeyoushoudendwork;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final String employer = 'Bananas_Potattos_Oranges';

  String time = '8:30';
  double width;
  double height;
  final String timeYouShouldGoHome = '15:00';

  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    width = window.physicalSize.width;
    height = window.physicalSize.height;


    _animationController.repeat();
    super.initState();
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 30));
    _animationController.addListener(() => setState(() {
//          testInt++;
//          print('testInt: $testInt');
    }));
  }

  @override
  Widget build(BuildContext context) {
    double radius = min(window.physicalSize.width/6, window.physicalSize.height/6)-7;

//    print('Szerokosc skranu = $width');

    double costam = height / width;
//    print('height: $height / width: $width = costam: $costam');
    fontsize = costam * 7.5;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5,),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        color: Color(0xff757575),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Add Employe',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.lightBlueAccent),
                                      ),
                                    ),
                                    TextField(
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: FlatButton(
                                        child: Text(
                                          'Add',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.lightBlueAccent,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: CustomCard(ferstText: 'Employer', secondText: employer),
            ),
            InkWell(
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    print('change $date in time zone' +
                        date.timeZoneOffset.inHours.toString());
                  },
                  onConfirm: (date) {
                    time = '${date.hour}:${date.minute}'.toString();
                    print('confirm $date');
                  },
                  currentTime: DateTime.now(),
                );
              },
              child: CustomCard(
                ferstText: 'Time you want to work',
                secondText: time,
              ),
            ),
            CustomCard(
              ferstText: 'Time you should go home',
              secondText: timeyoushoudendwork.toString(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: RadialProgress()
//                    GradientCircularProgressIndicator(
//                        gradientColors: [Colors.green, Colors.red],
//                        radius: radius, //costam * 80,
//                        strokeWidth: 30,
//                        value: new Tween(begin: 0.0, end: 1.0)
//                            .animate(
//                          CurvedAnimation(
//                              parent: _animationController,
//                              curve: Curves.linear),
//                        )
//                            .value),
                  ),
                ],
              ),
            ),
            CustomCard(
                ferstText: 'Total time spend at work', secondText: time),
            Row(
              children: <Widget>[
                Expanded(
                    child:
                    CustomCard(ferstText: 'Start work', secondText: null)),
                Expanded(
                    child:
                    CustomCard(ferstText: 'Stop work', secondText: null)),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text('START'),
                    onPressed: () {
                      setState(() {
                        _animationController.repeat();
                        _add();
                        var now = new DateTime.now();
                        var currenttime = new DateTime(now.year, now.month, now.day, now.hour, now.minute);
                        timeyoushoudendwork = currenttime.add(
                          Duration(hours: 8, minutes: 25),
                        );
                        print('now: $now');
                        print('timeyoushoudendwork: $timeyoushoudendwork');

                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text('STOP'),
                    onPressed: () {
                      setState(() {
                        _animationController.stop();
                        _sub();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Tu bedzie AB BAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _add() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = preferencesTest++;
    prefs.setInt(key, value);
    print(value);
  }

  _sub() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = preferencesTest--;
    prefs.setInt(key, value);
    print(value);
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({@required this.ferstText, @required this.secondText});
  final String ferstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      color: Colors.grey[800],
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Text(
          '$ferstText: $secondText',
          maxLines: 1,
          style: TextStyle(color: Colors.white, fontSize: fontsize),
        ),
      ),
    );
  }
}

class CustomCardWithTextField extends StatelessWidget {
  CustomCardWithTextField({
    @required this.ferstText,
  });
  final String ferstText;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      color: Colors.grey[800],
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                testInt++;
                print(testInt);
              },
              child: Text(
                '$ferstText: ',
                style: TextStyle(color: Colors.white, fontSize: fontsize),
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
