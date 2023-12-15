import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
    final String description;
    final String image;
    final String merek;
    final String name;
    final String price;
    final String price1Hari;
    final String price6Bulan;

    Car({
        required this.description,
        required this.image,
        required this.merek,
        required this.name,
        required this.price,
        required this.price1Hari,
        required this.price6Bulan,
    });

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        description: json["description"],
        image: json["image"],
        merek: json["merek"],
        name: json["name"],
        price: json["price"],
        price1Hari: json["price1Hari"],
        price6Bulan: json["price6Bulan"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "image": image,
        "merek": merek,
        "name": name,
        "price": price,
        "price1Hari": price1Hari,
        "price6Bulan": price6Bulan,
    };
}
