import 'package:flutter/material.dart';
import './session.dart';
import './exerciseList.dart';
import 'package:intl/intl.dart';
import '../models/exercise.dart';
import 'dart:math';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  final String plan;

  MyHomePage({this.plan});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final repsController = TextEditingController();
String dayname = DateFormat.EEEE().format(DateTime.now());

final List<Exercise> availableList = [
  Exercise(
      name: "Pushups",
      imageUrl: "assets/images/1.png",
      songUrl: "assets/audio/Song 14 - Rock.mp3",
      duration: 10),
  Exercise(
      name: "Chinups",
      imageUrl: "assets/images/2.png",
      songUrl: "assets/audio/Song 18 - Rock.mp3",
      duration: 9),
  Exercise(
      name: "Squats",
      imageUrl: "assets/images/4.png",
      songUrl: "assets/audio/Song 34 - Pop.mp3",
      duration: 8),
  Exercise(
      name: "Cardio",
      imageUrl: "assets/images/5.png",
      songUrl: "assets/audio/joined audio.mp3",
      duration: 7),
  Exercise(
      name: "Stretching",
      imageUrl: "assets/images/6.png",
      songUrl: "assets/audio/50 - Up from the ashes.mp3",
      duration: 6),
  Exercise(
      name: "Crunches",
      imageUrl: "assets/images/7.png",
      songUrl: "assets/audio/Song 14 - Rock.mp3",
      duration: 10),
  Exercise(
      name: "Chinups",
      imageUrl: "assets/images/8.png",
      songUrl: "assets/audio/Song 18 - Rock.mp3",
      duration: 9),
  Exercise(
      name: "Cardio",
      imageUrl: "assets/images/9.png",
      songUrl: "assets/audio/Song 34 - Pop.mp3",
      duration: 8),
  Exercise(
      name: "Yoga",
      imageUrl: "assets/images/10.png",
      songUrl: "assets/audio/joined audio.mp3",
      duration: 7),
  Exercise(
      name: "Pullups",
      imageUrl: "assets/images/11.png",
      songUrl: "assets/audio/50 - Up from the ashes.mp3",
      duration: 6),
];

class _MyHomePageState extends State<MyHomePage> {
  List<Exercise> randomList = [];
  bool checkedButton = false;
  int reps = 1;

  void generateRandomList() {
    randomList = [];
    var arr = [];
    Random rand = new Random();
    int min = 0, max = 9;
    while (arr.length < 5) {
      int r = min + rand.nextInt(max - min);
      if (!arr.contains(r)) {
        arr.add(r);
        setState(() {
          randomList.add(availableList[r]);
          checkedButton = true;
        });
      }
    }
  }

  void generateDaywiseList() {
    List<Exercise> monday = [
      availableList[0],
      availableList[1],
      availableList[2],
      availableList[3],
      availableList[4]
    ];
    List<Exercise> tuesday = [
      availableList[1],
      availableList[2],
      availableList[3],
      availableList[4],
      availableList[5]
    ];
    List<Exercise> wednesday = [
      availableList[2],
      availableList[3],
      availableList[4],
      availableList[5],
      availableList[6]
    ];
    List<Exercise> thursday = [
      availableList[3],
      availableList[4],
      availableList[5],
      availableList[6],
      availableList[7]
    ];
    List<Exercise> friday = [
      availableList[4],
      availableList[5],
      availableList[6],
      availableList[7],
      availableList[8]
    ];
    List<Exercise> saturday = [
      availableList[5],
      availableList[6],
      availableList[7],
      availableList[8],
      availableList[9]
    ];
    List<Exercise> sunday = [
      availableList[9],
      availableList[8],
      availableList[6],
      availableList[4],
      availableList[2]
    ];

    setState(() {
      switch (dayname) {
        case "Monday":
          randomList = monday;
          break;
        case "Tuesday":
          randomList = tuesday;
          break;
        case "Wednesday":
          randomList = wednesday;
          break;
        case "Thursday":
          randomList = thursday;
          break;
        case "Friday":
          randomList = friday;
          break;
        case "Saturday":
          randomList = saturday;
          break;
        case "Sunday":
          randomList = sunday;
          break;
        default:
          randomList = availableList;
      }
      checkedButton = false;
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomList();
  }

  void _startExercise(context) {
    print(reps);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Session(
        reps: reps,
        exerciseList: randomList,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fitHeight),
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
                      child: Text(
                        "Welcome Folks",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 40.0,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        "It's $dayname today.\nChoose your plan.",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: checkedButton
                                  ? Color(0xff04a870)
                                  : Color(0xffe9e9ea),
                              onPressed: () => generateRandomList(),
                              child: Text(
                                " RANDOMIZE Your wokouts ",
                                style: TextStyle(
                                    color: checkedButton
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RaisedButton(
                              color: checkedButton
                                  ? Color(0xffe9e9ea)
                                  : Color(0xff04a870),
                              onPressed: () => generateDaywiseList(),
                              child: Text(
                                "    DAY-WISE    ",
                                style: TextStyle(
                                    color: checkedButton
                                        ? Colors.grey
                                        : Colors.white),
                              ),
                            ),
                          ],
                        ),
                        ExerciseList(
                          availableList:
                              randomList.isEmpty ? availableList : randomList,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Select number of reps:",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Container(
                                  height: 100.0,
                                  width: 100,
                                  child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (selectedItem) {
                                        reps = selectedItem;
                                        print(selectedItem.runtimeType);
                                      },
                                      children: [
                                        Text("1"),
                                        Text("2"),
                                        Text("3"),
                                        Text("4"),
                                        Text("5"),
                                      ]),
                                )
                              ],
                            ),
                            Container(
                              height: 50.0,
                              width: 50.0,
                              child: GestureDetector(
                                onTap: () => _startExercise(context),
                                child: Image.asset("assets/images/play.png"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
