import 'package:get/get.dart';
import 'package:suuq_somali/create_listing/categories_list_model.dart';
import 'package:suuq_somali/models/all_ads_model.dart';
import 'package:suuq_somali/models/all_category_list.dart';
import 'package:suuq_somali/models/anything_model.dart';
import 'package:suuq_somali/models/anythings_mobile_category.dart';
import 'package:suuq_somali/models/car_model.dart';
import 'package:suuq_somali/models/property_model.dart';
import 'package:suuq_somali/services/all_category_service.dart';
import 'package:suuq_somali/services/anything_services.dart';
import 'package:suuq_somali/services/car_services.dart';
import 'package:suuq_somali/services/property_services.dart';
import 'package:suuq_somali/utils/Utility.dart';

class AllCategoryController extends GetxController {
  var getallCategory = AllCategoryList().obs;
  var allCategoryLoading = true.obs;
  ALLCategoryService service = ALLCategoryService();
  var cat = Cat();
  // int from;
  // var stateValue = StateValue();
  //
  AllCategoryController(this.cat);
  @override
  void onInit() {
    super.onInit();
    getCategoryDetails(cat.catSlug);
  }


  void getCategoryDetails(String slug) async {
    try {
      allCategoryLoading(true);

      var allCategoryListSata = await service.fetchCatDetailsData(slug);
      if (allCategoryListSata != null) {
        getallCategory.value = allCategoryListSata;


      }
    } finally {
      allCategoryLoading(false);
    }
  }
}
