import 'package:flutter/cupertino.dart';
import '../services/local_notification_service.dart';

class NotificationsViewModel extends ChangeNotifier {
  List<int> indexes = [];

  void showNotifications(
      {required String title, required String body, required int id}) {
    LocalNotificationService()
        .showNotification(title: title, body: body, id: id);
    indexes.add(id);
    notifyListeners();
  }

  void cancelOneNotifications({required int id}) {
    LocalNotificationService().cancelNotification(id);
    indexes.remove(id);
    notifyListeners();
  }

  void cancelAllNotifications() {
    LocalNotificationService().cancelAll();
    indexes.clear();
    notifyListeners();
  }
}
