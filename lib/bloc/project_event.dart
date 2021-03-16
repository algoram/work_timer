part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent {}

class InitialLoadingEvent extends ProjectEvent {}

class DisplayProjectEvent extends ProjectEvent {
  final Project project;

  DisplayProjectEvent(this.project);
}

class StopWorkingEvent extends ProjectEvent {
  final Project modifiedProject;

  StopWorkingEvent(this.modifiedProject);
}

class DeleteProjectEvent extends ProjectEvent {
  final Project project;

  DeleteProjectEvent(this.project);
}

class StartCreatingEvent extends ProjectEvent {}

class CreateProjectEvent extends ProjectEvent {
  final List<Project> projectList;

  CreateProjectEvent(this.projectList);
}
