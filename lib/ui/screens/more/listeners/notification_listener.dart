import 'package:another_flushbar/flushbar.dart';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/notification/notification_bloc.dart';
import 'package:coice/state/bloc/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget notificationListener({required Widget child}) {
  return BlocListener<NotificationBloc, NotificationState>(
    listener: (context, state) {
      
      if (state is NotificationLoaded) {
        Flushbar(
          title: 'New Notification',                   
          message: state.message,
          backgroundColor: AppColors.info,            
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(12),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(Icons.notifications,
              color: AppColors.white),               
        ).show(context);
      }
    },
    child: child,
  );
}
