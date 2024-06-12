import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocket_codex/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Since we're using contextful features of get like routing
  // GetMaterialApp is required for it to work
  // Do not change it to regular MaterialApp
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pocket Codex',
      onInit: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
    );
  }
}
