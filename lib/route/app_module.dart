import 'package:get/route_manager.dart';
import 'package:rk_admin/binding/add_reminder_binding.dart';
import 'package:rk_admin/binding/call_details_binding.dart';
import 'package:rk_admin/binding/edit_reminder_call_binding.dart';
import 'package:rk_admin/binding/home_binding.dart';
import 'package:rk_admin/binding/login_binding.dart';
import 'package:rk_admin/binding/reminder_call_managers_binding.dart';
import 'package:rk_admin/binding/splash_binding.dart';
import 'package:rk_admin/ui/pages/add_call_history_page.dart';
import 'package:rk_admin/ui/pages/add_call_page.dart';
import 'package:rk_admin/ui/pages/add_reminder_page.dart';
import 'package:rk_admin/ui/pages/call_details_page.dart';
import 'package:rk_admin/ui/pages/edit_reminder_call_page.dart';
import 'package:rk_admin/ui/pages/login_page.dart';
import 'package:rk_admin/ui/pages/home_page.dart';
import 'package:rk_admin/ui/pages/reminder_call_managers_page.dart';

import '../ui/pages/splashpage.dart';
import 'route.dart';

class AppPage {
  AppPage._();

  static final routes = [
    GetPage(
        name: AppRoute.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoute.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoute.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoute.addCall,
        page: () => const AddCallPage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoute.callDetails,
        page: () => const CallDetailsPage(),
        binding: CallDetailsBinding()),
    GetPage(
        name: AppRoute.addNewCall,
        page: () => const AddHistoryCall(),
        binding: CallDetailsBinding()),
    GetPage(
        name: AppRoute.reminderCallManagersPage,
        page: () => const ReminderCallManagersPage(),
        binding: ReminderCallManagerBinding()),

    // edit
    GetPage(
        name: AppRoute.editreminderCallManagersPage,
        page: () => const EditReminderCallPage(),
        binding: EditReminderCallBinding()),

    GetPage(
        name: AppRoute.addReminder,
        page: () => AddReminderPage(),
        binding: AddReminderBinding())
  ];
}
