import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:suuq_somali/models/property_model.dart';
import 'package:suuq_somali/models/search_model.dart';
import 'package:suuq_somali/services/search_services.dart';

class SearchController extends GetxController {
  var getSearch = Search().obs;
  var searchLoading = true.obs;
  SearchService searchService = SearchService();


 @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getSaerchDataCalling(
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
      var searchServices = await searchService.fetchSearchData(
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
