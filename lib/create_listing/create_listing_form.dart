import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suuq_somali/controller/property_controller.dart';
import 'package:suuq_somali/create_listing/category_list_controller.dart';
import 'package:suuq_somali/utils/app_theme.dart';
import 'package:http/http.dart' as http;

class CreateListFormPage extends StatefulWidget {
  @override
  _CreateListFormPageState createState() => _CreateListFormPageState();
}

class _CreateListFormPageState extends State<CreateListFormPage> {
  final CategoryListController crateListFormSearch =
      Get.put(CategoryListController());
  final PropertyController propertyCategory = Get.put(PropertyController());
  String selectedCity;
  String selectedArea;
  String selectedRoom;
  String bathrooms;
  String selectedCarSpace;
  List<Asset> images = <Asset>[];

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 8, right: 10.0),
      child: GridView.count(
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 5,
        crossAxisSpacing: 7,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AssetThumb(
              asset: asset,
              width: 200,
              height: 180,
            ),
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "icon"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final shortDesController = TextEditingController();

  final keys = GlobalKey<FormState>();
  bool isLoading = false;

  // String token;
  // String id;
  // void getTOken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   token = sharedPreferences.getString("loggedin_token");
  //   id = sharedPreferences.getString("id");
  //   setState(() {});
  // }

  final ImagePicker _picker = ImagePicker();
  File fileImage1;
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      fileImage1 = File(pickedFile.path);
    });
  }

  bool _isLoading = false;

  postAddData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("id");
    var token = sharedPreferences.getString("loggedin_token");
    var headers = {"Accept": "application/json"};
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://suuq.cwprojects.xyz/api/user/process-create-listing"),
    );
    request.headers.addAll(headers);
    //add text fields
    request.fields["token"] = token;
    request.fields["userid"] = id;
    request.fields["address"] = "";
    request.fields["area_code"] = "";
    request.fields["category_id"] = "";
    request.fields["city_id"] = "";
    request.fields["country_code"] = "";
    request.fields["custom_fields_ids"] = "";
    request.fields["description"] = "";
    request.fields["latlng"] = "";
    request.fields["listing_title"] = "";
    request.fields["phone"] = "";
    request.fields["postal_code"] = "";
    request.fields["price"] = "";
    request.fields["short_desc"] = "";
    request.fields["wa_area_code"] = "";
    request.fields["wa_area_code"] = "";
    request.fields["wa_phone"] = "";
    request.fields["cats[]"] = "";

    /// create multipart using filepath, string or bytes
    var pic =
        await http.MultipartFile.fromPath("uploaded_main_pic", fileImage1.path);
    // var multiplepic = await http.MultipartFile.fromPath("uploads[]",images);
    //add multipart to request
    request.files.add(pic);
    //   request.files.add(multiplepic);
    var response = await request.send();
    //Get the response from the server

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    Fluttertoast.showToast(
        msg: "Data insert Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    print("AAAAAAAAAAAA   ${responseString}");
  }

  // postAddData(
  //     {String address,
  //     String areaCode,
  //     categoryId,
  //     cityId,
  //     countryCode,
  //     customFiledsId,
  //     description,
  //     latLang,
  //     listingTitle,
  //     phoneNumber,
  //     postlCode,
  //     price,
  //     shortDescription,
  //     weAreaCode1,
  //     weAreaCode2,
  //     waPhone}) async {
  //   var headers = {
  //     'Cookie':
  //         'PHPSESSID=14fcb473ec1790d1ea7b521aeab70070; loggedin=5-localhost-271b2c4c2dc699c77cacc3bd09ee6977'
  //   };
  //   var body = {
  //     'token': token,
  //     'userid': id,
  //     'address': address,
  //     'area_code': areaCode,
  //     'category_id': categoryId,
  //     'city_id': cityId,
  //     'country_code': countryCode,
  //     'custom_fields_ids': customFiledsId,
  //     'description': description,
  //     'latlng': latLang,
  //     'listing_title': listingTitle,
  //     'phone': phoneNumber,
  //     'postal_code': postlCode,
  //     'price': price,
  //     'short_desc': shortDescription,
  //     'wa_area_code': weAreaCode1,
  //     'wa_area_code': weAreaCode1,
  //     'wa_phone': waPhone,
  //     'cats[]': '[173,174]'
  //   };
  //   var response = await http.post(
  //       Uri.parse(
  //           "https://suuq.cwprojects.xyz/api/user/process-create-listing"),
  //       body: body,
  //       headers: headers);
  //   if (response.statusCode == 200) {
  //     Map jsonData = json.decode(response.body);
  //     print("Body  ${response.body}");
  //  if(jsonData['status']==1){
  //    Fluttertoast.showToast(
  //        msg: "Data Inserted SucessFully",
  //        toastLength:
  //        Toast.LENGTH_SHORT,
  //        gravity:
  //        ToastGravity.BOTTOM,
  //        timeInSecForIosWeb: 4,
  //        backgroundColor:
  //        Colors.red,
  //        textColor: Colors.white,
  //        fontSize: 20.0);
  //    // Get.to(TabBarScreen());
  //  }else{
  //    Fluttertoast.showToast(
  //        msg:
  //        "Data Inserted SucessFully ",
  //        toastLength:
  //        Toast.LENGTH_SHORT,
  //        gravity:
  //        ToastGravity.BOTTOM,
  //        timeInSecForIosWeb: 4,
  //        backgroundColor:
  //        Colors.red,
  //        textColor: Colors.white,
  //        fontSize: 20.0);
  //  }
  //    return jsonData;
  //
  //   }
  // }

  // postAddData() async {
  //   var headers = {
  //     'Cookie': 'PHPSESSID=14fcb473ec1790d1ea7b521aeab70070; loggedin=5-localhost-271b2c4c2dc699c77cacc3bd09ee6977'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://suuq.cwprojects.xyz/api/user/process-create-listing'));
  //   request.fields.addAll({
  //     'token': token,
  //     'userid': id,
  //     'address': 'address',
  //     'area_code': '45454',
  //     'category_id': '173',
  //     'city_id': '1',
  //     'country_code': 'su',
  //     'custom_fields_ids': '32',
  //     'description': 'description',
  //     'latlng': '23.4545,4.5634',
  //     'listing_title': 'listing_title',
  //     'phone': '5645645646',
  //     'postal_code': '2323',
  //     'price': '454545',
  //     'short_desc': 'rtyertyertyerty',
  //     'wa_area_code': 'wa_area_code',
  //     'wa_area_code': 'wa_area_code',
  //     'wa_phone': 'wa_phone',
  //     'cats[]': '[173,174]'
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     Fluttertoast.showToast(
  //         msg:
  //         "Data inserted successfully!",
  //         toastLength:
  //         Toast.LENGTH_SHORT,
  //         gravity:
  //         ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 4,
  //         backgroundColor:Colors.white,
  //         textColor: Colors.red,
  //         fontSize: 20.0);
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Post Your Ad"),
        backgroundColor: HexColor("#dc3545"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Item Title..........

            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 18, bottom: 19, top: 20),
              child: TextField(
                decoration: InputDecoration(hintText: "Item Title"),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Price"),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            fileImage1 == null
                ? Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                        child: Text(
                          "No Image",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: fileImage1 == null
                                ? AssetImage("No Image Found...")
                                : FileImage(
                                    File(fileImage1.path),
                                  ),
                          )),
                    ),
                  ),

            // CircleAvatar(
            //   radius: 60.0,
            //   backgroundColor: Colors.black,
            //   child: CircleAvatar(
            //     // backgroundColor: Colors.indigo,
            //     radius: 57.0,
            //     backgroundImage: fileImage1 == null
            //         ? AssetImage("No Image Found...")
            //         : FileImage(
            //       File(fileImage1.path),
            //     ),
            //
            //     backgroundColor: Colors.white,
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, left: 30),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Text(
                      "Upload Main photo",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Short Description"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Description"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Address"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Postal Code"),
              ),
            ),
            Obx(() {
              if (propertyCategory.loading.value) {
                return Center(
                  child: SpinKitChasingDots(
                    color: Colors.red,
                    size: 20,
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 23.0, top: 18),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(color: Colors.white),
                  child: SearchableDropdown(
                    hint: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text("Location"),
                    ),
                    iconSize: 20,
                    displayClearIcon: true,
                    items: propertyCategory.getProperty.value.states.values
                        .map((e) {
                      return DropdownMenuItem(
                        child: Text(e.stateName),
                        value: e.stateName,
                      );
                    }).toList(),
                    value: selectedCity,
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Obx(
              () {
                if (propertyCategory.loading.value) {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15, right: 23),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(color: Colors.white),
                    child: DropdownButton(
                      iconSize: 30,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      hint: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          " Select Area",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      items: propertyCategory.getProperty.value.cities.values
                          .map((e) {
                        return DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Container(
                              child: ListTile(
                                title: Text(e.cityName),
                              ),
                            ),
                          ),
                          value: e.cityName,
                        );
                      }).toList(),
                      value: selectedArea,
                      onChanged: (text) {
                        setState(() {
                          selectedArea = text;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Phone Number"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Whats App Number"),
              ),
            ),
            Obx(
              () {
                if (crateListFormSearch.categoryLoading.value) {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.red,
                      size: 50.0,
                    ),
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 25, right: 25),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Rooms",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      items: crateListFormSearch.roomList.map((element) {
                        return DropdownMenuItem(
                          value: element,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              // ignore: unnecessary_brace_in_string_interps
                              "${element} Rooms",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedRoom,
                      onChanged: (text) {
                        setState(() {
                          selectedRoom = text;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () {
                if (crateListFormSearch.categoryLoading.value) {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.red,
                      size: 50.0,
                    ),
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 25, right: 25),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Bathrooms",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      items: crateListFormSearch.bathRooms.map((element) {
                        return DropdownMenuItem(
                          value: element,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              // ignore: unnecessary_brace_in_string_interps
                              "${element} Bathrooms",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                      value: bathrooms,
                      onChanged: (text) {
                        setState(() {
                          bathrooms = text;
                        });
                      },
                    ),
                  ),
                );
              },
            ),

            SizedBox(
              height: 10,
            ),
            Obx(
              () {
                if (crateListFormSearch.categoryLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 25, right: 25),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Car Space",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      items: crateListFormSearch.carSpace.map((element) {
                        return DropdownMenuItem(
                          value: element,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text(
                              // ignore: unnecessary_brace_in_string_interps
                              "${element} Car Space",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedCarSpace,
                      onChanged: (text) {
                        setState(() {
                          selectedCarSpace = text;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18, bottom: 19),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter house Size"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 18),
              child: TextField(
                decoration: InputDecoration(hintText: "Build Year"),
              ),
            ),
            // Text(
            //   "Add at least one photo",
            //   style: TextStyle(fontSize: 16),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     bottom: 10,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(color: Colors.white),
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           height: 8,
            //         ),
            //         images.isEmpty
            //             ? Icon(
            //                 Icons.camera_alt,
            //                 size: 50,
            //               )
            //             : buildGridView(),
            //         SizedBox(
            //           height: 15,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(bottom: 12.0),
            //           child: GestureDetector(
            //             onTap: loadAssets,
            //             child: Container(
            //               alignment: Alignment.center,
            //               decoration: BoxDecoration(
            //                 color: Colors.red,
            //               ),
            //               height: 40,
            //               width: 320,
            //               child: Text(
            //                 "Multiple photo",
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Column(
            //   children: [
            //
            //     _image == null
            //         ? Text('No image selected.')
            //         : Image.file(_image,cacheHeight: 100,fit: BoxFit.cover,),
            //
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 12.0),
            //       child: GestureDetector(
            //         onTap: (){
            //          getImage();
            //         },
            //         child: Container(
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //             color: Colors.red,
            //           ),
            //           height: 40,
            //           width: 320,
            //           child: Text(
            //             "Upload a Main Single Photo",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     bottom: 10,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(color: Colors.white),
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           height: 8,
            //         ),
            //         CircleAvatar(
            //           radius: 60.0,
            //           backgroundColor: Colors.black,
            //           child: CircleAvatar(
            //             // backgroundColor: Colors.indigo,
            //             radius: 57.0,
            //             backgroundImage: fileImage1 == null
            //                 ? AssetImage("No Image Found...")
            //                 : FileImage(
            //                     File(fileImage1.path),
            //                   ),
            //
            //             backgroundColor: Colors.white,
            //           ),
            //         ),
            //         SizedBox(
            //           height: 15,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(bottom: 12.0),
            //           child: GestureDetector(
            //             onTap: () {
            //               showModalBottomSheet(
            //                 context: context,
            //                 builder: ((builder) => bottomSheet()),
            //               );
            //             },
            //             child: Container(
            //               height: 40,
            //               width: 320,
            //               alignment: Alignment.center,
            //               decoration: BoxDecoration(
            //                 color: Colors.red,
            //               ),
            //               child: Text(
            //                 "Single photo",
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            // Container(
            //   decoration: BoxDecoration(color: Colors.white),
            //   child: Column(
            //     children: [
            //       // Padding(
            //       //   padding: const EdgeInsets.only(left: 25.0, right: 18),
            //       //   child: TextField(
            //       //     decoration:
            //       //         InputDecoration(hintText: "Description"),
            //       //   ),
            //       // ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 25.0, right: 18, bottom: 19),
            //         child: TextField(
            //           decoration: InputDecoration(hintText: "Price"),
            //         ),
            //       ),
            //
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 25.0, right: 18, bottom: 19),
            //         child: TextField(
            //           decoration: InputDecoration(hintText: "Address"),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 25.0, right: 18, bottom: 19),
            //         child: TextField(
            //           decoration:
            //               InputDecoration(hintText: "Postal code"),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 25.0, right: 18, bottom: 19),
            //         child: TextField(
            //           decoration: InputDecoration(hintText: "Build Year"),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 25.0, right: 18, bottom: 19),
            //         child: TextField(
            //           decoration:
            //               InputDecoration(hintText: "Short Description"),
            //         ),
            //       ),
            //       // SizedBox(height: 30,),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 100),
              child: GestureDetector(
                onTap: () {
                  // final addressValue = addressController.text;
                  // final priceValue = priceController.text;
                  // final desValue = descriptionController.text;
                  // final shortDescripValue = shortDesController.text;
                  postAddData();

                  // postAddData(
                  //   address: addressValue,
                  //   areaCode: "",
                  //   categoryId: "173",
                  //   cityId: "1",
                  //   countryCode: "su",
                  //   customFiledsId: "32",
                  //   description: desValue,
                  //   latLang: "",
                  //   listingTitle: "",
                  //   phoneNumber: "",
                  //   postlCode: "",
                  //   price: priceValue,
                  //   shortDescription: shortDescripValue,
                  //   weAreaCode1: "",
                  //   weAreaCode2: "",
                  //   waPhone: "",
                  // );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 40,
                  width: 150,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              ('Single Photo'),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  label: Text("Camera"),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    Navigator.pop(context);
                    takePhoto(ImageSource.gallery);
                  },
                  label: Text("Gallery"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
// class CreateListFormPage extends StatefulWidget {
//   @override
//   _CreateListFormPageState createState() => _CreateListFormPageState();
// }
//
// class _CreateListFormPageState extends State<CreateListFormPage> {
//   File image;
//   String token;
//   String id;
//   void getTOken() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     token = sharedPreferences.getString("loggedin_token");
//     id = sharedPreferences.getString("id");
//     setState(() {});
//   }
// createPostData()async{
//   var headers = {
//     'Cookie': 'PHPSESSID=0a43483ab3ebb04692faebf39578c770; '
//         'loggedin=5-localhost-f62739f55f7f92c28f8a47abc241fa42'
//   };
//   var request =  http.MultipartRequest('POST', Uri.parse('https://suuq.cwprojects.xyz/api/user/process-create-listing'));
//   request.fields.addAll({
//     'token': token,
//     'userid': id,
//     'address': 'address',
//     'area_code': '45454',
//     'category_id': '173',
//     'city_id': '1',
//     'country_code': 'su',
//     'custom_fields_ids': '32',
//     'description': 'description',
//     'latlng': '23.4545,4.5634',
//     'listing_title': 'listing_title',
//     'phone': '5645645646',
//     'postal_code': '2323',
//     'price': '454545',
//     'short_desc': 'rtyertyertyerty',
//     'wa_area_code': 'wa_area_code',
//     'wa_area_code': 'wa_area_code',
//     'wa_phone': 'wa_phone',
//     'cats[]': '[173,174]'
//   });
//   // request.files.add(await http.MultipartFile.fromPath('uploaded_main_pic', 'UW6wNoNSg/Screenshot 2021-04-17 at 2.47.57 PM.png'));
//   // request.files.add(await http.MultipartFile.fromPath('uploads[]', 'cv3LCKfPG/Screenshot 2021-04-18 at 12.46.30 PM.png'));
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   }
//   else {
//     print(response.reasonPhrase);
//   }
//
// }
//   // createPostData() async {
//   //   var request = await http.MultipartRequest(
//   //     "POST",
//   //     Uri.parse(
//   //       "https://suuq.cwprojects.xyz/api/user/process-create-listing",
//   //     ),
//   //   );
//   //   Map<String, String> headers = {
//   //     'Content-Type': 'multipart/form-data',
//   //   };
//   //   request.headers["Content-Type"] = 'multipart/form-data';
//   //   request.fields["token"] = token;
//   //   request.fields["userid"] = id;
//   //   request.fields["address"] = "hardik";
//   //   request.fields["uploaded_main_pic"] = "hardik";
//   //
//   //   request.fields["area_code"] = "h@gmail.com";
//   //   request.fields["category_id"] = "00000000";
//   //   request.fields["city_id"] = "afa";
//   //   request.fields["country_code"] = "fsf";
//   //   request.fields["uploads[]"] = "fsf";
//   //
//   //   if (image != null) {
//   //     print(image.path.split(".").last);
//   //     request.files.add(
//   //       http.MultipartFile.fromBytes(
//   //         "uploaded_main_pic",
//   //         image.readAsBytesSync(),
//   //         filename: "test.${image.path.split(".").last}",
//   //       //  contentType: MediaType("image", "${image.path.split(".").last}"),
//   //       ),
//   //     );
//   //   }
//   //
//   //   request.send().then((onValue) {
//   //     print(onValue.statusCode);
//   //     print(onValue.request);
//   //
//   //     print(onValue.headers);
//   //     print(onValue.contentLength);
//   //   });
//   // }
// @override
//   void initState() {
//     super.initState();
//     getTOken();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload "),
//         backgroundColor: Colors.red,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             RaisedButton(
//               onPressed: () {createPostData();},
//               child: Text("Upload"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
