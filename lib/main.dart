import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_timer/bloc/project_bloc.dart';
import 'package:work_timer/pages/create.dart';
import 'package:work_timer/pages/display.dart';
import 'package:work_timer/pages/home.dart';
import 'package:work_timer/pages/loading.dart';

void main() {
  runApp(WorkTimerApp());
}

class WorkTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ProjectBloc bloc = ProjectBloc();

        // load the initial data
        bloc.add(InitialLoadingEvent());

        return bloc;
      },
      child: MaterialApp(
        title: 'Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: SafeArea(
          child: BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectInitial) {
                return HomePage(
                  projectList: state.projectList,
                );
              } else if (state is DisplayProjectState) {
                return DisplayPage(
                  project: state.project,
                );
              } else if (state is LoadingState) {
                return LoadingPage();
              } else if (state is StartCreatingState) {
                return CreatePage(
                  projectList: state.projectList,
                );
              }

              // error has happened
              // TODO: create a better error page
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
