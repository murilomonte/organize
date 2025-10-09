import 'package:flutter/material.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';
import 'package:organize/src/organize.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/view_models/status_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  final db = AppDatabase();

  final repo = OrganizeRepository(
    groupsDao: db.groupsDao,
    tasksDao: db.tasksDao,
    subtasksDao: db.subtasksDao,
    statusDao: db.statusDao,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GroupViewModel(repo: repo)),  
        ChangeNotifierProvider(
          create: (context) => StatusViewModel(repo: repo),
        ),
      ],
      child: Organize(),
    ),
  );
}
