import 'package:flutter/material.dart';
import 'package:organize/src/data/database/status_enum.dart';

class OrganizeItemTile extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final List internalList;
  final void Function()? onTap;

  const OrganizeItemTile({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.internalList,
    this.onTap,
  });
  
  int _tasksDoneCount() {
    if (internalList.isNotEmpty) {
      int tasksDone = 0;

      internalList
          .where((element) => element.status == Status.completed)
          .forEach((element) => tasksDone++);
      return tasksDone;
    }
    return 0;
  }

  double _checkPercentage() {
    if (internalList.isNotEmpty) {
      int tasksDone = _tasksDoneCount();
      double percentage = (tasksDone / internalList.length) * 100;

      return percentage / 100;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
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
                    if (internalList.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(100),
                              minHeight: 5,
                              value: _checkPercentage(),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text('${_tasksDoneCount()}/${internalList.length} done'),
                        ],
                      ),
                  ],
                ),
              ),
              if (onTap != null) Icon(Icons.chevron_right, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
