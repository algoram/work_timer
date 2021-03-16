import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'project.dart';
import 'mainpage.dart';

void main() {
  runApp(WorkTimerApp());
}

class WorkTimerApp extends StatefulWidget {
  @override
  _WorkTimerAppState createState() => _WorkTimerAppState();
}

class _WorkTimerAppState extends State<WorkTimerApp> {
  List<Project> projectList = [];

  @override
  void initState() {
    super.initState();

    loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MainPage(
        projectList: projectList,
        addProject: addProject,
        refresh: refresh,
      ),
    );
  }

  bool addProject(Project project) {
    for (Project p in projectList) {
      if (p.name == project.name) {
        return false;
      }
    }

    setState(() {
      projectList.add(project);
    });

    saveProjects();

    return true;
  }

  void refresh() {
    saveProjects();

    setState(() {});
  }

  void loadProjects() async {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/projects.json');

    if (file.existsSync()) {
      String content = file.readAsStringSync();

      print(content);

      List<dynamic> json = jsonDecode(content)['projects'];

      setState(() {
        for (Map<String, dynamic> project in json) {
          projectList.add(Project.fromJson(project));
        }
      });
    } else {
      file.writeAsStringSync('{"projects":[]}', flush: true);

      setState(() {
        projectList = [];
      });
    }
  }

  void saveProjects() async {
    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/projects.json');

    Map<String, dynamic> json = Map();
    json['projects'] = projectList;

    file.writeAsStringSync(jsonEncode(json));
  }
}
