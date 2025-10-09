import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_status_tile.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/status_model.dart';
import 'package:organize/src/view_models/status_view_model.dart';
import 'package:provider/provider.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatusViewModel>().updateModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My progress'),
        // actionsPadding: EdgeInsets.all(10),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => Scaffold(
        //             appBar: AppBar(),
        //             body: Center(child: Text('Settings page')),
        //           ),
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.settings_outlined),
        //   ),
        // ],
      ),
      body: Consumer<StatusViewModel>(
        builder: (context, value, child) {
          StatusModel currentStatus = value.currentStatus;

          if (value.errorMsg.isNotEmpty) {
            return Center(child: Text(value.errorMsg));
          }

          if (value.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Column(
              children: [
                OrganizeStatusTile(
                  icon: Status.pending.icon,
                  label: 'Pending',
                  count: currentStatus.pending,
                ),
                OrganizeStatusTile(
                  icon: Status.inProgress.icon,
                  label: 'In progress',
                  count: currentStatus.inProgress,
                ),

                OrganizeStatusTile(
                  icon: Status.completed.icon,
                  label: 'Completed',
                  count: currentStatus.completed,
                ),

                OrganizeStatusTile(
                  icon: Icons.diamond_outlined,
                  label: 'Total score',
                  count: currentStatus.totalScore,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
