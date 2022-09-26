import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_taxi/models/user_model/user_model.dart';
import 'package:green_taxi/views/home.dart';
import 'package:green_taxi/views/profile_settings.dart';
import 'package:path/path.dart' as Path;
class AuthController extends GetxController{

  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  var isProfileUploading = false.obs;


  phoneAuth(String phone) async {
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Completed');
          credentials = credential;
          await FirebaseAuth.instance
              .signInWithCredential(credential);
        },
        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          log('Failed');
          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          log('Code sent');
          verId = verificationId;
          resendTokenId = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log("Error occured $e");
    }
  }

  verifyOtp(String otpNumber)async{
    log("Called");
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: otpNumber);

    log("LogedIn");

    await FirebaseAuth.instance
        .signInWithCredential(credential).then((value) {
          decideRoute();
    });
  }

  var isDecided = false;

  decideRoute(){

    if(isDecided){
      return;
    }
    isDecided = true;
    print("called");
    ///step 1- Check user login?
   User? user =  FirebaseAuth.instance.currentUser;

   if(user != null){
     /// step 2- Check whether user profile exists?
    FirebaseFirestore.instance.collection('users').doc(user.uid).get()
        .then((value) {
          if(value.exists){
            Get.offAll(()=> HomeScreen());
          }else{
            Get.offAll(()=> ProfileSettingScreen());
          }
    });

   }


  }




  uploadImage(File image)async{

    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName'); // Modify this path/string as your need
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
          (value) {
        imageUrl = value;
        print("Download URL: $value");
      },
    );

    return imageUrl;
  }

  storeUserInfo(File? selectedImage,String name,String home,String business,String shop,{String url = ''})async{
    String url_new = url;
    if(selectedImage != null){
      url_new  = await uploadImage(selectedImage);

    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': url_new,
      'name': name,
      'home_address': home,
      'business_address': business,
      'shopping_address': shop
    }).then((value) {

      isProfileUploading(false);

      Get.to(()=> HomeScreen());
    });
  }

  var myUser = UserModel(

  ).obs;

  getUserInfo(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots().listen((event) {
      myUser.value = UserModel.fromJson(event.data()!);
    });
  }

}