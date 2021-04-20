import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:suuq_somali/models/abirrr.dart';
import 'package:suuq_somali/models/anything_model.dart';

class SearchListCategory extends StatefulWidget {
  @override
  _SearchListCategoryState createState() => _SearchListCategoryState();
}

class _SearchListCategoryState extends State<SearchListCategory> {
  // ignore: missing_return
  Future<List<Cat>> getBlogListJsonData() async {
    String url = "https://suuq.cwprojects.xyz/api/anything";

    print("Url : $url");
    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        print("Response Popular Json Data :  ${response.body}");
        return Anything.fromJson(jsonDecode(response.body)).cats;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<SubCategoryList> categoryList(String slug) async {
    String url = "https://suuq.cwprojects.xyz/api/listings/$slug";

    print(" SubCategory Url : $url");
    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        print("SubCategory....>>  ${response.body}");
        return SubCategoryList.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception();
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Pick a Category"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            child: TextField(
              onChanged: (value) {
/*                setState(
                  () {
                    blogResponse2 = blogResponse
                        .where((element) => element.catName
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  },
                );*/
              },
              cursorColor: Colors.grey,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 25,
                  ),
                  border: InputBorder.none,
                  hintText: "Search for a category",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          ListTile(
            onTap: () {
              Get.back();
            },
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Go to all ads"),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: FutureBuilder<List<Cat>>(
                future: getBlogListJsonData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data;

                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        final item = list[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ExpansionTile(
                            trailing: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.white,
                            ),
                            title: Text(item.catName),
                            leading: Image.network(
                              item.catImg,
                              cacheHeight: 35,
                            ),
                            children: [
                              FutureBuilder<SubCategoryList>(
                                  future: categoryList(item.catSlug),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final list = snapshot.data.listItems;

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: list.length,
                                        itemBuilder: (_, index) {
                                          final item = list[index];
                                          return ListTile(
                                            onTap: () {},
                                            title: Text(item.listingTitle),
                                          );
                                        },
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text("${snapshot.error}"),
                                      );
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }

                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
