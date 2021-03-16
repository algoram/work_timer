import 'package:flutter/material.dart';
import 'package:work_timer/createpage.dart';
import 'package:work_timer/projectpage.dart';

import 'project.dart';

class MainPage extends StatelessWidget {
  final List<Project> projectList;
  final Function addProject;
  final Function refresh;

  const MainPage({Key key, this.projectList, this.addProject, this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  applicationVersion: '1.0.0',
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            projectList[index].name,
                            style: TextStyle(
                              fontSize: 32.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            projectList[index].getStringRepresentation(),
                            style: TextStyle(
                              fontSize: 32.0,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProjectPage(
                                project: projectList[index],
                              );
                            },
                          ),
                        ).then((value) {
                          refresh();
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemCount: projectList.length,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_alert),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return CreatePage(
                    addProject: addProject,
                  );
                },
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
