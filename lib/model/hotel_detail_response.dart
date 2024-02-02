// To parse this JSON data, do
//
//     final hotelDetailsResponse = hotelDetailsResponseFromJson(jsonString);

import 'dart:convert';

HotelDetailsResponse hotelDetailsResponseFromJson(String str) => HotelDetailsResponse.fromJson(json.decode(str));

String hotelDetailsResponseToJson(HotelDetailsResponse data) => json.encode(data.toJson());

class HotelDetailsResponse {
  HotelDetailData data;
  int status;

  HotelDetailsResponse({
    required this.data,
    required this.status,
  });

  factory HotelDetailsResponse.fromJson(Map<String, dynamic> json) => HotelDetailsResponse(
    data: HotelDetailData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
  };
}

class HotelDetailData {
  int? id;
  String? objectModel;
  String? title;
  String? price;
  dynamic salePrice;
  dynamic discountPercent;
  String? image;
  String? content;
  Location? location;
  dynamic isFeatured;
  String? address;
  String? mapLat;
  String? mapLng;
  int? mapZoom;
  String? bannerImage;
  List<String>? gallery;
  String? video;
  int? enableExtraPrice;
  List<ExtraPrice>? extraPrice;
  DataReviewScore? reviewScore;
  List<String>? reviewStats;
  ReviewLists? reviewLists;
  List<Policy>? policy;
  int? starRate;
  String? checkInTime;
  String? checkOutTime;
  dynamic allowFullDay;
  List<BookingFee>? bookingFee;
  List<Related>? related;
  Map<String, Term>? terms;

  HotelDetailData({
     this.id,
     this.objectModel,
     this.title,
     this.price,
     this.salePrice,
     this.discountPercent,
     this.image,
     this.content,
     this.location,
     this.isFeatured,
     this.address,
     this.mapLat,
     this.mapLng,
     this.mapZoom,
     this.bannerImage,
     this.gallery,
     this.video,
     this.enableExtraPrice,
     this.extraPrice,
     this.reviewScore,
     this.reviewStats,
     this.reviewLists,
     this.policy,
     this.starRate,
     this.checkInTime,
     this.checkOutTime,
     this.allowFullDay,
     this.bookingFee,
     this.related,
     this.terms,
  });

  factory HotelDetailData.fromJson(Map<String, dynamic> json) => HotelDetailData(
    id: json["id"],
    objectModel: json["object_model"],
    title: json["title"],
    price: json["price"],
    salePrice: json["sale_price"],
    discountPercent: json["discount_percent"],
    image: json["image"],
    content: json["content"],
    location: Location.fromJson(json["location"]),
    isFeatured: json["is_featured"],
    address: json["address"],
    mapLat: json["map_lat"],
    mapLng: json["map_lng"],
    mapZoom: json["map_zoom"],
    bannerImage: json["banner_image"],
    gallery: List<String>.from(json["gallery"].map((x) => x)),
    video: json["video"],
    enableExtraPrice: json["enable_extra_price"],
    extraPrice: List<ExtraPrice>.from(json["extra_price"].map((x) => ExtraPrice.fromJson(x))),
    reviewScore: DataReviewScore.fromJson(json["review_score"]),
    reviewStats: List<String>.from(json["review_stats"].map((x) => x)),
    reviewLists: ReviewLists.fromJson(json["review_lists"]),
    policy: List<Policy>.from(json["policy"].map((x) => Policy.fromJson(x))),
    starRate: json["star_rate"],
    checkInTime: json["check_in_time"],
    checkOutTime: json["check_out_time"],
    allowFullDay: json["allow_full_day"],
    bookingFee: List<BookingFee>.from(json["booking_fee"].map((x) => BookingFee.fromJson(x))),
    related: List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
    terms: Map.from(json["terms"]).map((k, v) => MapEntry<String, Term>(k, Term.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object_model": objectModel,
    "title": title,
    "price": price,
    "sale_price": salePrice,
    "discount_percent": discountPercent,
    "image": image,
    "content": content,
    "location": location?.toJson(),
    "is_featured": isFeatured,
    "address": address,
    "map_lat": mapLat,
    "map_lng": mapLng,
    "map_zoom": mapZoom,
    "banner_image": bannerImage,
    "gallery": List<dynamic>.from(gallery!.map((x) => x)),
    "video": video,
    "enable_extra_price": enableExtraPrice,
    "extra_price": List<dynamic>.from(extraPrice!.map((x) => x.toJson())),
    "review_score": reviewScore?.toJson(),
    "review_stats": List<dynamic>.from(reviewStats!.map((x) => x)),
    "review_lists": reviewLists?.toJson(),
    "policy": List<dynamic>.from(policy!.map((x) => x.toJson())),
    "star_rate": starRate,
    "check_in_time": checkInTime,
    "check_out_time": checkOutTime,
    "allow_full_day": allowFullDay,
    "booking_fee": List<dynamic>.from(bookingFee!.map((x) => x.toJson())),
    "related": List<dynamic>.from(related!.map((x) => x.toJson())),
    "terms": Map.from(terms!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class BookingFee {
  String name;
  String desc;
  String price;
  String unit;
  String type;

  BookingFee({
    required this.name,
    required this.desc,
    required this.price,
    required this.unit,
    required this.type,
  });

  factory BookingFee.fromJson(Map<String, dynamic> json) => BookingFee(
    name: json["name"],
    desc: json["desc"],
    price: json["price"],
    unit: json["unit"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "price": price,
    "unit": unit,
    "type": type,
  };
}

class ExtraPrice {
  String name;
  String price;
  String type;

  ExtraPrice({
    required this.name,
    required this.price,
    required this.type,
  });

  factory ExtraPrice.fromJson(Map<String, dynamic> json) => ExtraPrice(
    name: json["name"],
    price: json["price"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "type": type,
  };
}

class Location {
  int id;
  String name;

  Location({
    required this.id,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Policy {
  String title;
  String content;

  Policy({
    required this.title,
    required this.content,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}

class Related {
  int id;
  String objectModel;
  String title;
  String price;
  dynamic salePrice;
  dynamic discountPercent;
  String image;
  String content;
  Location location;
  int? isFeatured;
  RelatedReviewScore reviewScore;

  Related({
    required this.id,
    required this.objectModel,
    required this.title,
    required this.price,
    required this.salePrice,
    required this.discountPercent,
    required this.image,
    required this.content,
    required this.location,
    required this.isFeatured,
    required this.reviewScore,
  });

  factory Related.fromJson(Map<String, dynamic> json) => Related(
    id: json["id"],
    objectModel: json["object_model"],
    title: json["title"],
    price: json["price"],
    salePrice: json["sale_price"],
    discountPercent: json["discount_percent"],
    image: json["image"],
    content: json["content"],
    location: Location.fromJson(json["location"]),
    isFeatured: json["is_featured"],
    reviewScore: RelatedReviewScore.fromJson(json["review_score"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object_model": objectModel,
    "title": title,
    "price": price,
    "sale_price": salePrice,
    "discount_percent": discountPercent,
    "image": image,
    "content": content,
    "location": location.toJson(),
    "is_featured": isFeatured,
    "review_score": reviewScore.toJson(),
  };
}

class RelatedReviewScore {
  String scoreTotal;
  int totalReview;
  String reviewText;

  RelatedReviewScore({
    required this.scoreTotal,
    required this.totalReview,
    required this.reviewText,
  });

  factory RelatedReviewScore.fromJson(Map<String, dynamic> json) => RelatedReviewScore(
    scoreTotal: json["score_total"],
    totalReview: json["total_review"],
    reviewText: json["review_text"],
  );

  Map<String, dynamic> toJson() => {
    "score_total": scoreTotal,
    "total_review": totalReview,
    "review_text": reviewText,
  };
}

class ReviewLists {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  ReviewLists({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ReviewLists.fromJson(Map<String, dynamic> json) => ReviewLists(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int id;
  String title;
  String content;
  int rateNumber;
  String authorIp;
  String status;
  DateTime createdAt;
  int vendorId;
  int authorId;
  Author author;

  Datum({
    required this.id,
    required this.title,
    required this.content,
    required this.rateNumber,
    required this.authorIp,
    required this.status,
    required this.createdAt,
    required this.vendorId,
    required this.authorId,
    required this.author,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    rateNumber: json["rate_number"],
    authorIp: json["author_ip"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    vendorId: json["vendor_id"],
    authorId: json["author_id"],
    author: Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "rate_number": rateNumber,
    "author_ip": authorIp,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "vendor_id": vendorId,
    "author_id": authorId,
    "author": author.toJson(),
  };
}

class Author {
  int id;
  String name;
  String firstName;
  String lastName;
  dynamic avatarId;

  Author({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.avatarId,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatarId: json["avatar_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "avatar_id": avatarId,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class DataReviewScore {
  String scoreTotal;
  String scoreText;
  int totalReview;
  Map<String, RateScore> rateScore;

  DataReviewScore({
    required this.scoreTotal,
    required this.scoreText,
    required this.totalReview,
    required this.rateScore,
  });

  factory DataReviewScore.fromJson(Map<String, dynamic> json) => DataReviewScore(
    scoreTotal: json["score_total"],
    scoreText: json["score_text"],
    totalReview: json["total_review"],
    rateScore: Map.from(json["rate_score"]).map((k, v) => MapEntry<String, RateScore>(k, RateScore.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "score_total": scoreTotal,
    "score_text": scoreText,
    "total_review": totalReview,
    "rate_score": Map.from(rateScore).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class RateScore {
  String title;
  int total;
  int percent;

  RateScore({
    required this.title,
    required this.total,
    required this.percent,
  });

  factory RateScore.fromJson(Map<String, dynamic> json) => RateScore(
    title: json["title"],
    total: json["total"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "total": total,
    "percent": percent,
  };
}

class Term {
  Parent parent;
  List<Child> child;

  Term({
    required this.parent,
    required this.child,
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    parent: Parent.fromJson(json["parent"]),
    child: List<Child>.from(json["child"].map((x) => Child.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "parent": parent.toJson(),
    "child": List<dynamic>.from(child.map((x) => x.toJson())),
  };
}

class Child {
  int id;
  String title;
  dynamic content;
  dynamic imageId;
  String? icon;
  int attrId;
  String slug;

  Child({
    required this.id,
    required this.title,
    required this.content,
    required this.imageId,
    required this.icon,
    required this.attrId,
    required this.slug,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    imageId: json["image_id"],
    icon: json["icon"],
    attrId: json["attr_id"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image_id": imageId,
    "icon": icon,
    "attr_id": attrId,
    "slug": slug,
  };
}

class Parent {
  int id;
  String title;
  String slug;
  String service;
  dynamic displayType;
  dynamic hideInSingle;

  Parent({
    required this.id,
    required this.title,
    required this.slug,
    required this.service,
    required this.displayType,
    required this.hideInSingle,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    service: json["service"],
    displayType: json["display_type"],
    hideInSingle: json["hide_in_single"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "service": service,
    "display_type": displayType,
    "hide_in_single": hideInSingle,
  };
}
