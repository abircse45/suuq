import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:suuq_somali/models/property_model.dart';
import 'package:suuq_somali/models/search_model.dart';
import 'package:suuq_somali/services/filter_search_services_property.dart';

import 'car_search_service.dart';

class CarSearchController extends GetxController {
  var getSearch = FilterPropertySearch().obs;
  var searchLoading = true.obs;
  CarSearchService carsearchService = CarSearchService();


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void carGetSaerchDataCalling(
      String buy,
      String city,
      String area,
      String slectedPropertType,
      String carSpace,
      String bathrooms,
      String rooms,

      ) async {
    try {
      searchLoading(true);
      var searchServices = await carsearchService.carFetchSearchData(
          buy, city, area, slectedPropertType, carSpace, bathrooms, rooms);
      if (searchServices != null) {
        getSearch.value = searchServices;
        update();
      }
    } finally {
      searchLoading(false);
    }
  }
}
