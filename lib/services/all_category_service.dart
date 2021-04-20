import 'package:http/http.dart' as http;
import 'package:suuq_somali/models/all_category_list.dart';
import 'package:suuq_somali/models/anything_model.dart';
import 'package:suuq_somali/models/anythings_mobile_category.dart';
import 'package:suuq_somali/models/car_model.dart';

class ALLCategoryService {

  Future<AllCategoryList> fetchCatDetailsData(String slug) async {
    String url = "https://suuq.cwprojects.xyz/api/listings/$slug";
    print("All Cat service: $url");
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var allcat = response.body;
      return allCategoryListFromJson(allcat);

    }else{
      return null;
    }
  }
}


