import 'package:flutter/material.dart';
import 'package:organize/src/_core/widgets/description_button.dart';
import 'package:organize/src/_core/widgets/organize_item_tile.dart';
import 'package:organize/src/data/database/status_enum.dart';
import 'package:organize/src/models/group_model.dart';
import 'package:organize/src/view_models/group_view_model.dart';
import 'package:organize/src/views/group/group_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organize')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<GroupViewModel>(
            builder: (context, value, child) {
              List<GroupModel> groupList = value.getGroupList();

              if (value.errorMsg.isNotEmpty) {
                return Center(child: Text(value.errorMsg));
              }

              if (value.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (groupList.isEmpty) {
                return DescriptionButton(
                  description: 'There is no group yet',
                  buttonText: 'Add',
                  onTap: () {},
                );
              }
              return ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (context, index) {
                  return OrganizeItemTile(
                    id: groupList[index].id,
                    title: groupList[index].title,
                    description: groupList[index].description,
                    status: Status.pending,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupView(
                            id: groupList[index].id,
                            title: groupList[index].title,
                            description: groupList[index].description,
                            status: Status.pending,
                            createdAt: groupList[index].createdAt,
                            updatedAt: groupList[index].updatedAt,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
