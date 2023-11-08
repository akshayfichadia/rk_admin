import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rk_admin/dependency_injection.dart';
import 'package:rk_admin/route/app_module.dart';
import 'package:rk_admin/route/route.dart';

void main() async {
  await Get.putAsync(() => GetStorage.init());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  DependencyInjection.init();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SimpleBuilder(
      builder: (_) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          initialRoute: AppRoute.splash,
          getPages: AppPage.routes));
}
