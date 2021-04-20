// To parse this JSON data, do
//
//     final allCategoryList = allCategoryListFromJson(jsonString);

import 'dart:convert';

AllCategoryList allCategoryListFromJson(String str) => AllCategoryList.fromJson(json.decode(str));

String allCategoryListToJson(AllCategoryList data) => json.encode(data.toJson());

class AllCategoryList {
  AllCategoryList({
    this.status,
    this.cities,
    this.states,
    this.customFields,
    this.listItems,
  });

  int status;
  Map<String, City> cities;
  Map<String, State> states;
  AllCategoryListCustomFields customFields;
  List<ListItem> listItems;

  factory AllCategoryList.fromJson(Map<String, dynamic> json) => AllCategoryList(
    status: json["status"],
    cities: Map.from(json["cities"]).map((k, v) => MapEntry<String, City>(k, City.fromJson(v))),
    states: Map.from(json["states"]).map((k, v) => MapEntry<String, State>(k, State.fromJson(v))),
    customFields: AllCategoryListCustomFields.fromJson(json["custom_fields"]),
    listItems: List<ListItem>.from(json["list_items"].map((x) => ListItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "cities": Map.from(cities).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "states": Map.from(states).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "custom_fields": customFields.toJson(),
    "list_items": List<dynamic>.from(listItems.map((x) => x.toJson())),
  };
}

class City {
  City({
    this.cityId,
    this.cityName,
    this.state,
    this.stateId,
    this.slug,
    this.lat,
    this.lng,
  });

  String cityId;
  String cityName;
  String state;
  String stateId;
  String slug;
  String lat;
  String lng;

  factory City.fromJson(Map<String, dynamic> json) => City(
    cityId: json["city_id"],
    cityName: json["city_name"],
    state: json["state"],
    stateId: json["state_id"],
    slug: json["slug"],
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "city_name": cityName,
    "state": state,
    "state_id": stateId,
    "slug": slug,
    "lat": lat,
    "lng": lng,
  };
}

class AllCategoryListCustomFields {
  AllCategoryListCustomFields({
    this.the31,
  });

  The31 the31;

  factory AllCategoryListCustomFields.fromJson(Map<String, dynamic> json) => AllCategoryListCustomFields(
    the31: The31.fromJson(json["31"]),
  );

  Map<String, dynamic> toJson() => {
    "31": the31.toJson(),
  };
}

class The31 {
  The31({
    this.fieldId,
    this.fieldName,
    this.fieldType,
    this.filterDisplay,
    this.valuesList,
    this.tooltip,
    this.icon,
    this.required,
    this.fieldOrder,
    this.trFieldName,
    this.trValuesList,
  });

  String fieldId;
  String fieldName;
  String fieldType;
  String filterDisplay;
  List<String> valuesList;
  String tooltip;
  String icon;
  String required;
  String fieldOrder;
  String trFieldName;
  String trValuesList;

  factory The31.fromJson(Map<String, dynamic> json) => The31(
    fieldId: json["field_id"],
    fieldName: json["field_name"],
    fieldType: json["field_type"],
    filterDisplay: json["filter_display"],
    valuesList: List<String>.from(json["values_list"].map((x) => x)),
    tooltip: json["tooltip"],
    icon: json["icon"],
    required: json["required"],
    fieldOrder: json["field_order"],
    trFieldName: json["tr_field_name"],
    trValuesList: json["tr_values_list"],
  );

  Map<String, dynamic> toJson() => {
    "field_id": fieldId,
    "field_name": fieldName,
    "field_type": fieldType,
    "filter_display": filterDisplay,
    "values_list": List<dynamic>.from(valuesList.map((x) => x)),
    "tooltip": tooltip,
    "icon": icon,
    "required": required,
    "field_order": fieldOrder,
    "tr_field_name": trFieldName,
    "tr_values_list": trValuesList,
  };
}

class ListItem {
  ListItem({
    this.listingId,
    this.address,
    this.areaCode,
    this.catIcon,
    this.catName,
    this.catSlug,
    this.cityName,
    this.citySlug,
    this.countryAbbr,
    this.countryCall,
    this.countryName,
    this.isFeat,
    this.lat,
    this.listingLink,
    this.listingPrice,
    this.listingSlug,
    this.listingTitle,
    this.lng,
    this.mainPicUrl,
    this.phone,
    this.photoUrl,
    this.postalCode,
    this.rating,
    this.shortDesc,
    this.stateId,
    this.stateAbbr,
    this.stateSlug,
    this.mainCatId,
    this.mainCatSlug,
    this.submissionDate,
    this.customFields,
  });

  String listingId;
  String address;
  String areaCode;
  String catIcon;
  String catName;
  String catSlug;
  String cityName;
  String citySlug;
  CountryAbbr countryAbbr;
  String countryCall;
  String countryName;
  String isFeat;
  String lat;
  String listingLink;
  String listingPrice;
  String listingSlug;
  String listingTitle;
  String lng;
  String mainPicUrl;
  String phone;
  String photoUrl;
  String postalCode;
  String rating;
  String shortDesc;
  String stateId;
  String stateAbbr;
  String stateSlug;
  String mainCatId;
  String mainCatSlug;
  int submissionDate;
  ListItemCustomFields customFields;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
    listingId: json["listing_id"],
    address: json["address"],
    areaCode: json["area_code"],
    catIcon: json["cat_icon"],
    catName: json["cat_name"],
    catSlug: json["cat_slug"],
    cityName: json["city_name"],
    citySlug: json["city_slug"],
    countryAbbr: countryAbbrValues.map[json["country_abbr"]],
    countryCall: json["country_call"],
    countryName: json["country_name"],
    isFeat: json["is_feat"],
    lat: json["lat"],
    listingLink: json["listing_link"],
    listingPrice: json["listing_price"],
    listingSlug: json["listing_slug"],
    listingTitle: json["listing_title"],
    lng: json["lng"],
    mainPicUrl: json["main_pic_url"],
    phone: json["phone"],
    photoUrl: json["photo_url"],
    postalCode: json["postal_code"],
    rating: json["rating"],
    shortDesc: json["short_desc"],
    stateId: json["state_id"],
    stateAbbr: json["state_abbr"],
    stateSlug: json["state_slug"],
    mainCatId: json["main_cat_id"],
    mainCatSlug: json["main_cat_slug"],
    submissionDate: json["submission_date"],
    customFields: ListItemCustomFields.fromJson(json["custom_fields"]),
  );

  Map<String, dynamic> toJson() => {
    "listing_id": listingId,
    "address": address,
    "area_code": areaCode,
    "cat_icon": catIcon,
    "cat_name": catName,
    "cat_slug": catSlug,
    "city_name": cityName,
    "city_slug": citySlug,
    "country_abbr": countryAbbrValues.reverse[countryAbbr],
    "country_call": countryCall,
    "country_name": countryName,
    "is_feat": isFeat,
    "lat": lat,
    "listing_link": listingLink,
    "listing_price": listingPrice,
    "listing_slug": listingSlug,
    "listing_title": listingTitle,
    "lng": lng,
    "main_pic_url": mainPicUrl,
    "phone": phone,
    "photo_url": photoUrl,
    "postal_code": postalCode,
    "rating": rating,
    "short_desc": shortDesc,
    "state_id": stateId,
    "state_abbr": stateAbbr,
    "state_slug": stateSlug,
    "main_cat_id": mainCatId,
    "main_cat_slug": mainCatSlug,
    "submission_date": submissionDate,
    "custom_fields": customFields.toJson(),
  };
}

enum CountryAbbr { SO }

final countryAbbrValues = EnumValues({
  "SO": CountryAbbr.SO
});

class ListItemCustomFields {
  ListItemCustomFields({
    this.the31,
  });

  String the31;

  factory ListItemCustomFields.fromJson(Map<String, dynamic> json) => ListItemCustomFields(
    the31: json["31"],
  );

  Map<String, dynamic> toJson() => {
    "31": the31,
  };
}

class State {
  State({
    this.stateId,
    this.stateName,
    this.stateAbbr,
    this.slug,
    this.countryAbbr,
    this.countryId,
  });

  String stateId;
  String stateName;
  String stateAbbr;
  String slug;
  CountryAbbr countryAbbr;
  String countryId;

  factory State.fromJson(Map<String, dynamic> json) => State(
    stateId: json["state_id"],
    stateName: json["state_name"],
    stateAbbr: json["state_abbr"],
    slug: json["slug"],
    countryAbbr: countryAbbrValues.map[json["country_abbr"]],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "state_name": stateName,
    "state_abbr": stateAbbr,
    "slug": slug,
    "country_abbr": countryAbbrValues.reverse[countryAbbr],
    "country_id": countryId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
