

import 'package:http/http.dart' as http;
import 'package:suuq_somali/models/search_model.dart';

class SearchService {
  Future<Search> fetchSearchData(
    String cat_id_buy,
    String city,
    String selectedArea,
    String selectPropertyType,
    String carSpace,
    String bathrooms,
    String rooms,
    ) async {
  String url = "https://suuq.cwprojects.xyz/api/results?cat_id=$cat_id_buy&city=&field_32=&field_32=$selectPropertyType&field_33=&field_34=&field_37=";
    var response = await http.get(Uri.parse(url));
    print("URL $url");
    print("Property Search Url ${response.body}");
    print("Property Search Url ${response.statusCode}");

    if (response.statusCode == 200) {
      var search = response.body;
      return searchFromJson(search);
    } else {
      return null;
    }
  }
}

//"https://suuq.cwprojects.xyz/results?cat_id=173&city=&field_32=&field_32=Normal+House&field_33=&field_34=&field_37=&min_price=&max_price="