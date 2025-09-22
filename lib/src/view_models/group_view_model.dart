import 'package:flutter/material.dart';
import 'package:organize/src/data/repositories/organize_repository.dart';

class GroupViewModel extends ChangeNotifier {
  final OrganizeRepository repository;

  GroupViewModel({
    required this.repository
  });

}