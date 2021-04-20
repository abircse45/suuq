import 'package:get/get.dart';
import 'package:suuq_somali/models/all_ads_model.dart';
import 'package:suuq_somali/models/anything_model.dart';
import 'package:suuq_somali/models/car_model.dart';
import 'package:suuq_somali/models/property_model.dart';
import 'package:suuq_somali/services/all_ads_services.dart';
import 'package:suuq_somali/services/anything_services.dart';
import 'package:suuq_somali/services/car_services.dart';
import 'package:suuq_somali/services/property_services.dart';

class AllAdsController extends GetxController {
  var getAllAds = AllAds().obs;
  var allAdsLoading = true.obs;

  AllAdsService allAdsService = AllAdsService();

  @override
  void onInit() {
    super.onInit();
    getDataCalling();
  }

  void getDataCalling() async {
    try {
      allAdsLoading(true);
      var allAdsServices = await allAdsService.fetchData();
      if (allAdsServices != null) {
        getAllAds.value = allAdsServices;
      }
    } finally {
      allAdsLoading(false);
    }
  }
}
