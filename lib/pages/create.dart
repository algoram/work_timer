import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_timer/bloc/project_bloc.dart';

import '../project.dart';

class CreatePage extends StatelessWidget {
  final List<Project> projectList;
  final GlobalKey<FormState> formKey = GlobalKey();

  CreatePage({Key key, this.projectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a project'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<ProjectBloc>(context)
                .add(CreateProjectEvent(projectList));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Project name',
                      border: OutlineInputBorder(),
                      helperText: 'Must be at least 3 characters long',
                    ),
                    validator: (String input) {
                      if (input == null || input.length < 3) {
                        return 'Must be 3 characters long';
                      }

                      for (Project p in projectList) {
                        if (p.name == input) {
                          return 'Project already exists';
                        }
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Text('CREATE'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    projectList
                        .add(Project(controller.text, Stopwatch(), Duration()));

                    BlocProvider.of<ProjectBloc>(context)
                        .add(CreateProjectEvent(projectList));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
