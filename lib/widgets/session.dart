import 'package:flutter/material.dart';
import 'package:rough/models/exercise.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';

class Session extends StatefulWidget {
  final int reps;
  final List<Exercise> exerciseList;

  Session({this.reps, this.exerciseList});

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  int time = 0;
  final oneSec = Duration(seconds: 1);
  String imageName = "assets/images/Break.png";
  AssetsAudioPlayer assetsAudioPlayer;
  bool isCompleted = false;
  String secs = "secs";
  String exerciseName = 'Exercise';
  int exerciseCount;
  int repetitions = 0;

  void initExercise(counter) {
    assetsAudioPlayer.open(Audio(widget.exerciseList[counter].songUrl));
    assetsAudioPlayer.play();
    time = widget.exerciseList[counter].duration;
    Timer _timer = Timer.periodic(oneSec, (Timer timer) {
      if (time < 1) {
        timer.cancel();
        counter += 1;
        assetsAudioPlayer.stop();
        initBreak(counter);
      } else {
        setState(() {
          exerciseName = widget.exerciseList[counter].name;
          imageName = widget.exerciseList[counter].imageUrl;
          time -= 1;
        });
      }
    });
  }

  void initBreak(counter) {
    if (counter == 5) {
      completed();
    } else {
      time = 3;
      Timer _breakTimer = Timer.periodic(oneSec, (Timer timer) {
        if (time < 1) {
          timer.cancel();
          initExercise(counter);
        } else {
          setState(() {
            exerciseName = "Relax for 40secs";
            imageName = "assets/images/Break.png";
            time -= 1;
          });
        }
      });
    }
  }

  void completed() {
    repetitions += 1;
    if (repetitions == widget.reps) {
      isCompleted = true;
      setState(() {
        exerciseName = "No More Tasks";
        imageName = "";
        secs = "Hurray, Completed!!";
      });
    } else {
      initExercise(0);
    }
  }

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer();
    initExercise(0);
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        exerciseName,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 30.0,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(25.0),
                        child: isCompleted
                            ? Image.asset(
                                "assets/images/completed.png",
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                imageName,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            isCompleted ? "" : "$time",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 80.0,
                            ),
                          ),
                          Text(
                            "$secs",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 30.0,
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
    );
  }
}
