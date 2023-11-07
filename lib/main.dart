import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rk_admin/dependency_injection.dart';
import 'package:rk_admin/route/app_module.dart';
import 'package:rk_admin/route/route.dart';

void main() async {
  await Get.putAsync(() => GetStorage.init());
  DependencyInjection.init();
  runApp(const MyApp());
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
