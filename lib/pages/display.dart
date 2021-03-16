import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_timer/bloc/project_bloc.dart';
import 'package:work_timer/project.dart';

class DisplayPage extends StatefulWidget {
  final Project project;

  const DisplayPage({Key key, this.project}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool isRunning = false;
  String timeDisplayed;
  Timer timer;

  @override
  void initState() {
    super.initState();

    timeDisplayed = widget.project.getTotalElapsedTime();

    if (timer == null) {
      timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          if (isRunning) {
            setState(() {
              timeDisplayed = widget.project.getTotalElapsedTime();
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (isRunning) {
              widget.project.stopwatch.stop();

              setState(() {
                isRunning = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('The project was stopped')),
              );
            }

            BlocProvider.of<ProjectBloc>(context)
                .add(StopWorkingEvent(widget.project));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        onPressed: () {
          if (isRunning) {
            widget.project.stopwatch.stop();
          } else {
            widget.project.stopwatch.start();
          }

          setState(() {
            isRunning = !isRunning;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text(
          timeDisplayed,
          style: TextStyle(fontSize: 96.0),
        ),
      ),
    );
  }
}
