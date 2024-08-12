import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Provider/task_provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/widgets/list_of_works.dart';

class TimeTaskScreen extends StatefulWidget {
  static const String routeName = '/time-task';
  final String name;
  const TimeTaskScreen({
    super.key,
    required this.name,
  });

  @override
  State<TimeTaskScreen> createState() => _TimeTaskScreenState();
}

class _TimeTaskScreenState extends State<TimeTaskScreen> {
  List<Task> sortedList = [];

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name.isNotEmpty ? "${widget.name} Tasks" : "Completed Tasks",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      if (val.isEmpty) {
                        sortedList = [];
                      }
                      sortedList = taskProvider.onQuery(
                        val,
                        taskProvider.onTime(widget.name),
                      );
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search here...",
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListOfWorks(
                    listOfTask: widget.name.isEmpty
                        ? taskProvider.compltedList
                        : sortedList.isNotEmpty
                            ? sortedList
                            : taskProvider.onTime(widget.name),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
