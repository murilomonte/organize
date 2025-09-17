import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/tasks_group_detail.dart';

class TasksGroup extends StatelessWidget {
  final String title;
  final String? description;
  final List taskList;

  const TasksGroup({
    super.key,
    required this.title,
    this.description,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          showGeneralDialog(
            context: context,
            fullscreenDialog: false,
            barrierDismissible: true, // se pode fechar clicando fora
            barrierLabel: "Fechar", // acessibilidade
            pageBuilder: (context, animation, secondaryAnimation) {
              return TasksGroupDetail(title: title, description: description, taskList: [],);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description != null)
                      Text(description!, overflow: TextOverflow.ellipsis),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(100),
                            minHeight: 5,
                            value: .2,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text('20%'),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
