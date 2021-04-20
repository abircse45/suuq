import 'package:get/get.dart';
import 'package:suuq_somali/car/car_search_controller.dart';
import 'package:suuq_somali/controller/all_ads_controller.dart';
import 'package:suuq_somali/controller/anything_controller.dart';
import 'package:suuq_somali/controller/car_controller.dart';
import 'package:suuq_somali/controller/all_category_controller.dart';
import 'package:suuq_somali/controller/property_controller.dart';
import 'package:suuq_somali/controller/search_controller.dart';
import 'package:suuq_somali/models/anything_model.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyController>(() => PropertyController());
    Get.lazyPut<CarController>(() => CarController());
    Get.lazyPut<AnyThingController>(() => AnyThingController());
    Get.lazyPut<AllAdsController>(() => AllAdsController());
    //Get.lazyPut<AllCategoryController>(() =>AllCategoryController(c));
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<CarSearchController>(() => CarSearchController());
  }
}
