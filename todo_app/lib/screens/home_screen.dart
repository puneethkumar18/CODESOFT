import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Provider/task_provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_add_screen.dart';
import 'package:to_do_list/widgets/drawer.dart';
import 'package:to_do_list/widgets/list_of_works.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  // List<Task> names = [
  //   Task(
  //     name: "puneeth",
  //     category: "home",
  //     description: "Tell me abount task",
  //     completeIn: "monthly",
  //   ),
  //   Task(
  //     name: "puneeth",
  //     category: "home",
  //     description: "Tell me abount task",
  //     completeIn: "daily",
  //   ),
  //   Task(
  //     name: "puneeth",
  //     category: "home",
  //     description: "Tell me abount task",
  //     completeIn: 'monthly',
  //   ),
  //   Task(
  //     name: "puneeth",
  //     category: "home",
  //     description: "Tell me abount task",
  //     completeIn: 'weekly',
  //   ),
  // ];

  List<Task>? sortedList;
  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    return Scaffold(
      key: _scaffoldState,
      drawer: const DrawerWidget(),
      drawerScrimColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldState.currentState!.openDrawer();
          },
        ),
        title: const Text(
          "To Do",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) {
                if (val.isEmpty) {
                  sortedList = null;
                }
                sortedList = taskProvider.onQuery(
                  val,
                  taskProvider.taskList,
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
              height: 20,
            ),
            ListOfWorks(
              listOfTask:
                  sortedList != null ? sortedList! : taskProvider.taskList,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.amber,
        onPressed: () {
          Navigator.pushNamed(
            context,
            TaskAddScreen.routeName,
          );
        },
        child: const Icon(
          Icons.task_alt_sharp,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
