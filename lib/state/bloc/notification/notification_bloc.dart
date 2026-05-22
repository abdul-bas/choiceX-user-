import 'package:coice/data/repository/notification_repository.dart';
import 'package:coice/state/bloc/notification/notification_event.dart';
import 'package:coice/state/bloc/notification/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository notificationRepository = NotificationRepository();
  NotificationBloc() : super(NotificationInitial()) {
    on<AddNotification>((event, emit) async {
      emit(NotificationLoading());
      final resulte =
          await notificationRepository.addNotification(event.notification);
      emit(resulte);
    });
  }
}
