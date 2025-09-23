import 'package:flutter/material.dart';
import 'package:organize/src/data/database/app_database.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';
import 'package:organize/src/organize.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(900, 600),
    minimumSize: Size(600, 600),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final db = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GroupViewModel(
            repo: OrganizeRepository(
              groupsDao: db.groupsDao,
              tasksDao: db.tasksDao,
              subtasksDao: db.subtasksDao,
              statusDao: db.statusDao,
            ),
          ),
        ),
      ],
      child: Organize(),
    ),
  );
}
