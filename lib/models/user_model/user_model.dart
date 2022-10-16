import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel {
  String? bAddress;
  String? hAddress;
  String? mallAddress;
  String? name;
  String? image;

  LatLng? homeAddress;
  LatLng? bussinessAddres;
  LatLng? shoppingAddress;


  UserModel({this.name,this.mallAddress,this.hAddress,this.bAddress,this.image});

  UserModel.fromJson(Map<String,dynamic> json){
    bAddress = json['business_address'];
    hAddress = json['home_address'];
    mallAddress = json['shopping_address'];
    name = json['name'];
    image = json['image'];
    homeAddress = LatLng(json['home_latlng'].latitude, json['home_latlng'].longitude);
    bussinessAddres = LatLng(json['business_latlng'].latitude, json['business_latlng'].longitude);
    shoppingAddress = LatLng(json['shopping_latlng'].latitude, json['shopping_latlng'].longitude);
  }
}