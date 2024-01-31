// To parse this JSON data, do
//
//     final welcomeSuccess = welcomeSuccessFromJson(jsonString);

import 'dart:convert';

WelcomeSuccess welcomeSuccessFromJson(String str) =>
    WelcomeSuccess.fromJson(json.decode(str));

String welcomeSuccessToJson(WelcomeSuccess data) => json.encode(data.toJson());

class WelcomeSuccess {
  List<Hit> hits;
  num pages;
  num processingTimeMs;
  String query;

  WelcomeSuccess({
    required this.hits,
    required this.pages,
    required this.processingTimeMs,
    required this.query,
  });

  factory WelcomeSuccess.fromJson(Map<String, dynamic> json) => WelcomeSuccess(
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
        pages: json["pages"],
        processingTimeMs: json["processing_time_ms"],
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
        "pages": pages,
        "processing_time_ms": processingTimeMs,
        "query": query,
      };
}

class Hit {
  String id;
  String title;
  String link;
  String? description;
  String? category;
  String image;
  String gtin;
  String? brand;
  String? gender;
  String? ageGroup;
  num basePrice;
  String? currency;
  List<Variant> variants;
  List<String> labels;

  Hit({
    required this.id,
    required this.title,
    required this.link,
    required this.description,
    required this.category,
    required this.image,
    required this.gtin,
    required this.brand,
    required this.gender,
    required this.ageGroup,
    required this.basePrice,
    required this.currency,
    required this.variants,
    required this.labels,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
        gtin: json["gtin"],
        brand: json["brand"],
        gender: json["gender"],
        ageGroup: json["age_group"],
        basePrice: json["base_price"],
        currency: json["currency"],
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
        labels: List<String>.from(json["labels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "description": description,
        "category": category,
        "image": image,
        "gtin": gtin,
        "brand": brand,
        "gender": gender,
        "age_group": ageGroup,
        "base_price": basePrice,
        "currency": currency,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "labels": List<dynamic>.from(labels.map((x) => x)),
      };
}

class Variant {
  String size;
  num price;
  String? currency;

  Variant({
    required this.size,
    required this.price,
    required this.currency,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        size: json["size"],
        price: json["price"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "price": price,
        "currency": currency,
      };
}
