import 'dart:convert';

class GroceryData{
  List<Model> data = [
  Model(
    name: "Rice",
    imageUrl: "assets/images/rice.jpg",
    description: "Gold Plus Basmati rice for healthy family",
    address: "Big Bazaar Kharagpur" ,
    quantity: 3,
    price: 20
  ),
  Model(
    name: "Dal",
    imageUrl: "assets/images/dall.jpg",
    description: "Gold Plus Basmati rice for healthy family",
    address: "Big Bazaar Kharagpur" ,
    quantity: 2,
    price: 100
  ),
  Model(
    name: "Paneer",
    imageUrl: "assets/images/paneer.jpg",
    description: "Gold Plus Basmati rice for healthy family",
    address: "Big Bazaar Kharagpur" ,
    quantity: 1,
    price: 120
  ),
  Model(
    name: "Atta",
    imageUrl: "assets/images/atta.jpg",
    description: "Gold Plus Basmati rice for healthy family",
    address: "Big Bazaar Kharagpur" ,
    quantity: 5,
    price: 30
  )
];

}

// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);



List<Model> modelFromJson(String str) => List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
    Model({
        this.name,
        this.imageUrl,
        this.quantity,
        this.description,
        this.address,
        this.price,
    });

    String? name;
    String? imageUrl;
    String? description;
    String? address;
    int? quantity;
    int? price;

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        name: json["name"],
        imageUrl: json["imageUrl"],
        quantity: json["quantity"],
        price: json["price"],
        description: json["description"],
        address: json["address"]
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "quantity": quantity,
        "price": price,
        "description": description,
        "address": address
    };
}


