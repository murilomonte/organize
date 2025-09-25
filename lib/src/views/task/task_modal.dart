import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/_core/widgets/organize_modal.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/subtask_model.dart';

class TasksModal extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubtaskModel> subtaskList;

  const TasksModal({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subtaskList,
  });

  @override
  Widget build(BuildContext context) {
    return OrganizeModal(
      children: [
        Text(title, style: TextStyle(fontSize: 30)),
        if (description != null) Text(description!),
        Row(spacing: 20, children: [Text('$createdAt'), Text('$updatedAt')]),
        SizedBox(height: 20),
        if (subtaskList.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não há nenhum conjunto de tarefas ainda. ',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Adicionar um conjunto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        if (subtaskList.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: subtaskList.length,
              itemBuilder: (context, index) {
                return OrganizeItemTile(
                  id: subtaskList[index].id!,
                  title: subtaskList[index].title,
                  description: subtaskList[index].description,
                  status: Status.pending,
                  internalList: [],
                  
                );
              },
            ),
          ),
      ],
    );
  }
}
