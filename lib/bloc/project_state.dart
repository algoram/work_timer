part of 'project_bloc.dart';

@immutable
abstract class ProjectState {}

class ProjectInitial extends ProjectState {
  final List<Project> projectList;

  ProjectInitial(this.projectList);
}

class DisplayProjectState extends ProjectState {
  final Project project;

  DisplayProjectState(this.project);
}

class LoadingState extends ProjectState {}

class StartCreatingState extends ProjectState {
  final List<Project> projectList;

  StartCreatingState(this.projectList);
}
