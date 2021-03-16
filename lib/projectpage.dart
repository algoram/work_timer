import 'dart:async';

import 'package:flutter/material.dart';

import 'project.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  const ProjectPage({Key key, this.project}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  bool isRunning = false;
  Timer timer;
  String timeElapsed;

  void initState() {
    super.initState();

    timeElapsed = widget.project.getStringRepresentation();

    if (timer == null) {
      timer = Timer.periodic(
        Duration(
          seconds: 1,
        ),
        (timer) {
          if (isRunning) {
            redraw();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.project.name,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (isRunning) {
                widget.project.stopwatch.stop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('The project was stopped'),
                  ),
                );
              }

              setState(() {
                isRunning = false;
              });

              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Text(
            timeElapsed,
            style: TextStyle(
              fontSize: 96.0,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: () {
            if (!isRunning) {
              widget.project.stopwatch.start();
            } else {
              widget.project.stopwatch.stop();
            }

            setState(() {
              isRunning = !isRunning;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void redraw() {
    setState(() {
      timeElapsed = widget.project.getStringRepresentation();
    });
  }
}
