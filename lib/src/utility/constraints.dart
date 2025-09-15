import 'package:flutter/material.dart';

bool isMobileLayout(BuildContext context) =>
    MediaQuery.sizeOf(context).width < 600;
