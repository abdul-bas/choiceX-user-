import 'package:flutter/material.dart';

class TrackingEvent {
  final String title;
  final String description;
  final bool isCompleted;
  final bool isCurrent;
  final IconData icon;

  TrackingEvent({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isCurrent = false,
    required this.icon,
  });
}