import 'package:get/get.dart';
import 'package:suuq_somali/All_Search/all_search_model.dart';
import 'package:suuq_somali/All_Search/all_search_services.dart';


class ChangeAllSearchController extends GetxController {
  var getAllSearch = AllSearch().obs;
  var allSearchLoading = true.obs;

  ChangeAllSearchService allSearchService = ChangeAllSearchService();


  @override
  void onInit() {
    super.onInit();

  }

  void getDataCalling(String text) async {
    try {
      allSearchLoading (true);
      var allAdsServices = await allSearchService.fetchDataChange(text);
      if (allAdsServices != null) {
        getAllSearch.value = allAdsServices;
      }
    } finally {
      allSearchLoading(false);
    }
  }
}
