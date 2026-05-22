import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/order/order_bloc/order_bloc.dart';
import 'package:coice/state/bloc/order/order_state/cancellation_request_state.dart';
import 'package:coice/state/bloc/order/order_state/return_request_state.dart';
import 'package:coice/state/bloc/order/order_state/update_request_state.dart';
import 'package:coice/ui/screens/order/dialogs/status_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget requestUpdateValidation({
  required Widget Function(String status, bool isValid, bool isCancelled)
      child,
}) {
  return BlocConsumer<OrderBloc, OrderBlocState>(
    listenWhen: (previous, current) => current is UpdateRequestState,
    listener: (context, state) {
      if (state is UpdateRequestState && !state.validate) {
        final cleanStatus = state.newStatus
            .replaceAll('(', '')
            .replaceAll(')', '')
            .trim();
        showDialog(
          context: context,
          barrierColor: AppColors.overlayBarrier,          
          builder: (_) => StatusUpdateDialog(newStatus: cleanStatus),
        );
      }
    },
    builder: (context, state) {
      final isCancelled = state is CancellationRequestSuccess;
      final isLoading   = state is ReturnRequestLoading;
      final isValid     = state is UpdateRequestState ? state.validate : false;
      final newStatus   = state is UpdateRequestState
          ? state.newStatus.replaceAll('(', '').replaceAll(')', '').trim()
          : '';

      return Stack(
        children: [
          child(newStatus, isValid, isCancelled),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.overlayLoading,          
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.white70,                   
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}