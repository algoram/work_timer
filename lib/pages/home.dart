import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_timer/bloc/project_bloc.dart';
import 'package:work_timer/project.dart';

class HomePage extends StatelessWidget {
  final List<Project> projectList;

  const HomePage({Key key, this.projectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your projects'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Work Timer',
                applicationVersion: '1.1.0',
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert),
        onPressed: () {
          BlocProvider.of<ProjectBloc>(context).add(StartCreatingEvent());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            key: Key(projectList[index].name),
            title: Row(
              children: [
                Text(
                  projectList[index].name,
                  style: TextStyle(fontSize: 24.0),
                ),
                Spacer(),
                Text(
                  projectList[index].getTotalElapsedTime(),
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            onTap: () {
              BlocProvider.of<ProjectBloc>(context)
                  .add(DisplayProjectEvent(projectList[index]));
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete ${projectList[index].name}?'),
                    content: Text(
                        'The project and the time spent on it will be deleted.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<ProjectBloc>(context)
                              .add(DeleteProjectEvent(projectList[index]));

                          Navigator.of(context).pop();
                        },
                        child: Text('DELETE'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: projectList.length,
      ),
    );
  }
}
