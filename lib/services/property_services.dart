import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:suuq_somali/models/ResponseListener.dart';
import 'package:suuq_somali/models/property_model.dart';
import 'package:suuq_somali/utils/Utility.dart';

class PropertyService {
  Future<NewProperty> fetchData() async {
    String url = "https://suuq.cwprojects.xyz/api/property";
    var response = await http.get(Uri.parse(url));
    try {
      var responseCode = response.statusCode;
      if (responseCode == 200) {
        var property = response.body;
      return  newPropertyFromJson(property);
        // return ResponseListener(Utility.PROPERTY_LIST, responseCode, res);
      } else {
        return null;
        // return ResponseListener(Utility.PROPERTY_LIST, responseCode, null);;
      }
    } catch(e){

    }
  }
}
