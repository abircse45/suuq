import 'package:get/get.dart';
import 'package:suuq_somali/models/anything_model.dart';
import 'package:suuq_somali/models/car_model.dart';
import 'package:suuq_somali/models/property_model.dart';
import 'package:suuq_somali/services/anything_services.dart';
import 'package:suuq_somali/services/car_services.dart';
import 'package:suuq_somali/services/property_services.dart';

class AnyThingController extends GetxController {
  var getAnything = Anything().obs;
  var anyLoading = true.obs;
  List<String> selectCategory = [];
  AnyThingService service = AnyThingService();

  @override
  void onInit() {
    super.onInit();
    getDataCalling();
  }

  void getDataCalling() async {
    try {
      anyLoading(true);
      var anyResult = await service.fetchData();
      if (anyResult != null) {
        getAnything.value = anyResult;


      }
    } finally {
      anyLoading(false);
    }
  }
}
