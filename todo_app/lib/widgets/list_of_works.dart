import 'package:flutter/material.dart';

import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/widgets/task_details_screen.dart';

class ListOfWorks extends StatelessWidget {
  final List<Task> listOfTask;
  const ListOfWorks({
    super.key,
    required this.listOfTask,
  });

  @override
  Widget build(BuildContext context) {
    return listOfTask.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  ' You dont have any task! \n Please add task .',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: listOfTask.length,
            itemBuilder: (context, index) {
              final curr = listOfTask[index];
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Color.fromRGBO(162, 238, 239, 1)
                          : Color.fromRGBO(157, 202, 235, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          TaskDetailsScreen.routeName,
                          arguments: curr,
                        );
                      },
                      child: ListTile(
                        trailing: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Type:',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              curr.completeIn,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        title: Text(
                          curr.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Categoty : ${curr.category}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              );
            },
          );
  }
}
