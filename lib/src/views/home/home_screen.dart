import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/group/group_modal.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Consumer<GroupViewModel>(
              builder: (context, value, child) {
                if (value.errorMsg.isNotEmpty) {
                  return Center(child: Text(value.errorMsg),);
                }

                if (value.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (value.groupList.isEmpty) {
                  return Center(
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'There is no group yet',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Add',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: value.groupList.length,
                  itemBuilder: (context, index) {
                    return OrganizeItemTile(
                      id: value.groupList[index].id,
                      title: value.groupList[index].title,
                      description: value.groupList[index].description,
                      status: Status.pending,
                      internalList: value.groupList[index].tasks,
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          fullscreenDialog: false,
                          barrierDismissible: true,
                          barrierLabel: "Close",
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                                return GroupModal(
                                  id: value.groupList[index].id,
                                  title: value.groupList[index].title,
                                  description: value.groupList[index].description,
                                  status: Status.pending,
                                  taskList: value.groupList[index].tasks,
                                  createdAt: value.groupList[index].createdAt,
                                  updatedAt: value.groupList[index].updatedAt,
                                );
                              },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
