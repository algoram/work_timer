import 'package:flutter/material.dart';
import 'package:work_timer/project.dart';

class CreatePage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Function addProject;

  CreatePage({Key key, this.addProject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a new project'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              child: Text(
                'CREATE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (addProject(
                      Project(controller.text, Stopwatch(), Duration()))) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'A project with that name already exists',
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    border: OutlineInputBorder(),
                    helperText: 'Must be at least 3 characters long',
                  ),
                  validator: (String input) {
                    if (input == null || input.length < 3) {
                      return 'Must be at least 3 characters long';
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
