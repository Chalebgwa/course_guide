import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/models/notification_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationsController extends ChangeNotifier {
  final Auth auth;
  List<NotificationModel> notifications = [];

  NotificationsController(this.auth);

  Stream<List<NotificationModel>> getNotifications() {
    final uid = auth.currentUser?.uid;
    print(0);

    if (uid != null) {
      final stream = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("notifications")
          .snapshots();

      return stream.map<List<NotificationModel>>((event) =>
          event.docs.map((e) => NotificationModel.fromJson(e.data())).toList());
    }

    return const Stream<List<NotificationModel>>.empty();
  }
}
