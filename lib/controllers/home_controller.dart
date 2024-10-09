import 'package:flutter/material.dart';
import '../views/notifications_page.dart';
import '../views/schedule_page.dart';
import '../views/contacts_page.dart';
import '../views/service_status_page.dart';
import '../views/receipts_reviews_page.dart';
import '../views/settings_page.dart';

class HomeController {
  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Você pressionou $message')),
    );
  }

  void navigateToNotificationsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsPage()),
    );
  }

  // Adicione este método à classe HomeController
  void navigateToSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  void handleBottomNavigationTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        showMessage(context, 'Home');
        break;
      case 1:
        showMessage(context, 'Pesquisar');
        break;
      case 2:
        showMessage(context, 'Notificações');
        break;
    }
  }

  void navigateToSchedulePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SchedulePage()),
    );
  }

  void navigateToContactsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactsPage()),
    );
  }

  void navigateToServiceStatusPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ServiceStatusPage()),
    );
  }

  void navigateToReceiptsReviewsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReceiptsReviewsPage()),
    );
  }
}
