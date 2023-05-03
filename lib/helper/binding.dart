import 'package:el_marsa/core/view_model/auth_view_model.dart';
import 'package:el_marsa/core/view_model/control_view_model.dart';
import 'package:el_marsa/core/view_model/payment_view_model.dart';
import 'package:el_marsa/core/view_model/profile_view_model.dart';
import 'package:el_marsa/helper/local_storage_data.dart';
import 'package:get/instance_manager.dart';

import '../core/view_model/cart_view_model.dart';
import '../core/view_model/home_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => PaymentViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => LocalStorgeData());
  }
}
