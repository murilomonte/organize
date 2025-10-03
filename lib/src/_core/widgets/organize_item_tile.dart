import 'package:flutter/material.dart';
import 'package:organize/src/data/database/status_enum.dart';

class OrganizeItemTile extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final Status status;
  final void Function()? onTap;

  const OrganizeItemTile({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // print(status);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
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
                    Row(
                      spacing: 10,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (status == Status.completed)
                          Icon(
                            Icons.task_alt,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      ],
                    ),
                    if (description != null)
                      Text(description!, overflow: TextOverflow.ellipsis),
                    
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
