import 'package:get/get.dart';
import 'package:pocket_codex/app/screens/home/home.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
