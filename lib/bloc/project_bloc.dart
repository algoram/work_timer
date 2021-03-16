import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../project.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial([]));

  List<Project> projectList = [];

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    if (event is DisplayProjectEvent) {
      yield DisplayProjectState(event.project);
    } else if (event is StopWorkingEvent) {
      yield LoadingState();

      // replace the old project with the new one
      for (int i = 0; i < projectList.length; i++) {
        if (projectList[i].name == event.modifiedProject.name) {
          projectList[i] = event.modifiedProject;
        }
      }

      await saveProjects(projectList);

      yield ProjectInitial(projectList);
    } else if (event is DeleteProjectEvent) {
      yield LoadingState();

      // delete the project
      int index = -1;

      for (int i = 0; i < projectList.length; i++) {
        if (projectList[i].name == event.project.name) {
          index = i;
        }
      }

      projectList.removeAt(index);

      await saveProjects(projectList);

      yield ProjectInitial(projectList);
    } else if (event is StartCreatingEvent) {
      yield StartCreatingState(projectList);
    } else if (event is CreateProjectEvent) {
      yield LoadingState();

      // overwrite the old list with the new one which
      // may contain a new project or not
      projectList = event.projectList;

      await saveProjects(projectList);

      yield ProjectInitial(projectList);
    } else if (event is InitialLoadingEvent) {
      yield LoadingState();

      projectList = await loadProjects();

      yield ProjectInitial(projectList);
    }
  }
}

Future<List<Project>> loadProjects() async {
  List<Project> projectList = [];

  Directory directory = await getApplicationDocumentsDirectory();

  File file = File('${directory.path}/projects.json');

  if (file.existsSync()) {
    String content = file.readAsStringSync();

    List<dynamic> json = jsonDecode(content)['projects'];

    for (Map<String, dynamic> project in json) {
      projectList.add(Project.fromJson(project));
    }
  } else {
    file.writeAsStringSync('{"projects":[]}', flush: true);

    projectList = [];
  }

  return projectList;
}

Future saveProjects(List<Project> projectList) async {
  Directory directory = await getApplicationDocumentsDirectory();

  File file = File('${directory.path}/projects.json');

  Map<String, dynamic> json = Map();
  json['projects'] = projectList;

  file.writeAsStringSync(jsonEncode(json));
}
