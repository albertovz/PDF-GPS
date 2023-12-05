import 'dart:convert';

import 'package:paw_rescue/src/domain/models/user_data.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    String id;
    String image;
    String name;
    String description;
    String idUser;
    String contentType;
    String category;
    List<String> likes;
    UserData? userData;
    String latitud;
    String longitud;

    Post({
        this.id = '',
        this.image = '',
        this.name = '',
        this.description = '',
        this.idUser = '',
        this.category = '',
        this.contentType = '',
        this.likes = const [],
        this.userData,
        this.latitud = '',
        this.longitud = ''
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] ?? '',
        image: json["image"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        idUser: json["id_user"] ?? '',
        category: json["category"] ?? '',
        contentType: json["contentType"] ?? '',
        likes: json["likes"] != null ? List.from(json["likes"] )  : [],
        latitud: json["latitud"] ?? '',
        longitud: json["longitud"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "contentType": contentType,
        "id_user": idUser,
        "category": category,
        "likes": likes,
        "latitud": latitud,
        "longitud": longitud
    };
}

