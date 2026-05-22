import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/retrun_and_refund/return_and_refund.dart';
import 'package:coice/state/bloc/order/order_state/cancellation_request_state.dart';
import 'package:coice/state/bloc/order/order_state/return_request_state.dart';
import 'package:coice/state/bloc/order/order_state/update_request_state.dart';

class OrderRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<OrderBlocState> createReturnRequest(ReturnRequestModel request) async {
    try {
      await firestore
          .collection('return_and_refund')
          .doc(request.requestId)
          .set(request.toJson());

      return ReturnRequestSuccess("Return request created successfully");
    } catch (e) {
      return ReturnRequestFailure(e.toString());
    }
  }

  Future<void> updateAsRead(String orderId) async {
    try {
      final querySnapshot = await firestore
          .collection('return_and_refund')
          .where('orderId', isEqualTo: orderId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("No document found for this orderId");
        return;
      }

      final docRef = querySnapshot.docs.first.reference;

      await docRef.set(
        {'isRead': true},
        SetOptions(merge: true),
      );

      print("Marked as read successfully");
    } catch (e) {
      print("Error updating read status: $e");
    }
  }

  Future<bool> containsOrder(String orderId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('return_and_refund')
        .where('orderId', isEqualTo: orderId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

   getRefundStatus(String orderId)  {
   return  FirebaseFirestore.instance
        .collection('return_and_refund')
        .where('orderId', isEqualTo: orderId)
        .limit(1)
        .snapshots();
    

   
  }

  Future<OrderBlocState> updateRequest(String orderId) async {
    try {
      final result = await firestore
          .collection('return_and_refund')
          .where('orderId', isEqualTo: orderId)
          .get();

      if (result.docs.isEmpty) {
        return UpdateRequestState(
          newStatus: 'pending',
          validate: true,
          amount: 0.0,
          paymentId: '123',
        );
      }

      final docData = result.docs.first.data();

      final refundModel = ReturnRequestModel.fromJson(docData);

      return UpdateRequestState(
        newStatus: refundModel.status.toString(),
        validate: refundModel.isRead,
        amount: refundModel.amount,
        paymentId: refundModel.paymentId,
      );
    } catch (e) {
      return UpdateRequestStateError(e.toString());
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getParticularOrder(
      orderId) async {
    return firestore.collection('orders').doc(orderId).get();
  }

  Future<OrderBlocState> cancelOrder(String orderId, String reason) async {
    try {
      await firestore.collection('orders').doc(orderId).update({
        'cancellationReason': reason,
        'status': 'cancelled',
        'cancelledAt': DateTime.now().toIso8601String(),
      });

      return CancellationRequestSuccess("Order cancelled successfully.");
    } catch (e) {
      return CancellationRequestStateFailure("Failed to cancel order: $e");
    }
  }
}
