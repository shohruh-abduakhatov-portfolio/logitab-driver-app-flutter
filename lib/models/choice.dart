import 'package:driver_app_flutter/pages/logs_page.dart';
import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'LOGS', icon: Icons.access_time),
  const Choice(title: 'PROFILE', icon: Icons.person),
  const Choice(title: 'DVIR', icon: Icons.playlist_add_check),
  const Choice(title: 'SIGNATURE', icon: Icons.gesture),
];
