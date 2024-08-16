import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Provider/task_provider.dart';
import 'package:to_do_list/common/utils.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/widgets/custom_textfield.dart';

class TaskAddScreen extends StatefulWidget {
  static const String routeName = '/task-add';
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String value = 'Daily';
  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _taskNameController.dispose();
  }

  Task makeTaskModel() {
    return Task(
      name: _taskNameController.text.trim(),
      category: _categoryController.text.trim(),
      description: _descriptionController.text,
      completeIn: value,
      isCompleted: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Your Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Task Form:  ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  text: "Enter the title Of the Task",
                  controller: _taskNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  text: "Category (ex: home,personal....)",
                  controller: _categoryController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  text: "Enter the title Of the Task",
                  controller: _descriptionController,
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.white70,
                    elevation: 0,
                    value: value,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    items: time.map(
                      (String? val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val!,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      value = val!;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = makeTaskModel();
                        taskProvider.addtask(task);
                        Navigator.pushNamed(
                          context,
                          HomeScreen.routeName,
                        );
                      }
                    },
                    child: const Text(
                      "Submit Form",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
