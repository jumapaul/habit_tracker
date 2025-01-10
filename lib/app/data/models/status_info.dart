import 'dart:ui';

class StatusInfo {
  StatusInfo(this.name, this.totalTime, [this.color]);

  final String name;
  final int totalTime;
  final Color? color;
}