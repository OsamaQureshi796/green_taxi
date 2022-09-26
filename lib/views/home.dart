import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_webservice/places.dart';
import 'package:green_taxi/views/my_profile.dart';

import '../controller/auth_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String? _mapStyle;

  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    authController.getUserInfo();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

   final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: buildDrawer(),
      body:Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
                myMapController!.setMapStyle(_mapStyle);
              }, initialCameraPosition:_kGooglePlex,
            ),
          ),


          buildProfileTile(),

          buildTextField(),

          showSourceField ? buildTextFieldForSource(): Container(),

          buildCurrentLocationIcon(),

          buildNotificationIcon(),

          buildBottomSheet(),

        ],
      ),
    );
  }


  Widget buildProfileTile(){
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(()=>authController.myUser.value.name == null? Center(child: CircularProgressIndicator(),) :Container(
        width: Get.width,
        height: Get.width*0.5,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white70
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:authController.myUser.value.image == null? DecorationImage(
                      image: AssetImage('assets/person.png'),
                      fit: BoxFit.fill
                  ):DecorationImage(
                      image: NetworkImage(authController.myUser.value.image!),
                      fit: BoxFit.fill
                  )
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Good Morning, ',
                            style: TextStyle(color: Colors.black,fontSize: 14)
                        ),
                        TextSpan(
                            text: authController.myUser.value.name,
                            style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                      ]
                  ),
                ),
                Text("Where are you going?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),)
              ],
            )

          ],
        ),
      )),
    );
  }




  Future<String> showGoogleAutoComplete()async{

    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "us",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: AppConstants.kGoogleApiKey,
      components: [new Component(Component.country, "us")],
      types: ["(cities)"],
      hint: "Search City",);

    return p!.description!;
  }

  TextEditingController destinationController = TextEditingController();
  TextEditingController sourceController = TextEditingController();

  bool showSourceField = false;

  Widget buildTextField(){
    return  Positioned(
      top: 170,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        height: 50,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          controller: destinationController,
          readOnly: true,
          onTap: ()async{
      String selectedPlace =   await showGoogleAutoComplete();

          destinationController.text = selectedPlace;

          setState(() {
            showSourceField = true;
          });

          },
          style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,),
          decoration: InputDecoration(
            hintText: 'Search for a destination',
            hintStyle: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,

              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldForSource(){
    return  Positioned(
      top: 230,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        height: 50,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          controller: sourceController,
          readOnly: true,
          onTap: ()async{

            Get.bottomSheet(Container(
              width: Get.width,
              height: Get.height*0.5,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                const SizedBox(
                  height: 10,
                ),

                  Text("Select Your Location",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                  const SizedBox(
                    height: 20,
                  ),


                  Text("Home Address",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: Get.width,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          spreadRadius: 4,
                          blurRadius: 10
                        )
                      ]
                    ),
                    child: Row(
                      children: [
                        Text("KDA, KOHAT",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),textAlign: TextAlign.start,),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  Text("Business Address",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: Get.width,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 4,
                              blurRadius: 10
                          )
                        ]
                    ),
                    child: Row(
                      children: [
                        Text("Tehsil, KOHAT",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),textAlign: TextAlign.start,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  InkWell(
                    onTap: ()async{
                      Get.back();
                      String place = await showGoogleAutoComplete();
                      sourceController.text = place;

                    },
                    child: Container(
                      width: Get.width,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                spreadRadius: 4,
                                blurRadius: 10
                            )
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Search for Address",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),textAlign: TextAlign.start,),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ));

          },
          style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,),
          decoration: InputDecoration(
            hintText: 'From:',
            hintStyle: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,

              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }


  Widget buildCurrentLocationIcon(){
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30,right: 8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
          child: Icon(Icons.my_location,color: Colors.white,),
        ),

      ),
    );
  }

  Widget buildNotificationIcon(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30,left: 8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Icon(Icons.notifications,color: Color(0xffC3CDD6),),
        ),
      ),
    );
  }

  Widget buildBottomSheet(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width*0.8,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 4,
              blurRadius: 10
            )
          ],
          borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))
        ),
        child: Center(
          child: Container(
            width: Get.width*0.6,
            height: 4,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  buildDrawerItem({required String title,required Function onPressed,Color color = Colors.black,double fontSize = 20,FontWeight fontWeight = FontWeight.w700,double height = 45,bool isVisible = false}) {
    return SizedBox(
      height: height,
      child: ListTile(

        contentPadding: EdgeInsets.all(0),
        // minVerticalPadding: 0,
        dense: true,
        onTap: ()=> onPressed(),
        title: Row(
          children: [
            Text(title,style: GoogleFonts.poppins(fontSize: fontSize,fontWeight: fontWeight,color: color),),

            const SizedBox(width: 5,),

           isVisible? CircleAvatar(backgroundColor: AppColors.greenColor,radius: 15,child: Text('1',style: GoogleFonts.poppins(color: Colors.white),),):Container()

          ],
        ),
      ),
    );
  }

  buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(()=> const MyProfile());
            },
            child: SizedBox(
              height: 150,
              child: DrawerHeader(

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: authController.myUser.value.image == null?const DecorationImage(
                                image: AssetImage('assets/person.png'),
                                fit: BoxFit.fill
                            ): DecorationImage(
                                image: NetworkImage(authController.myUser.value.image!),
                                fit: BoxFit.fill
                            )
                        ),
                      ),

                      const SizedBox(width: 10,),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Good Morning, ',
                                style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.28),fontSize: 14)
                            ),
                            Text(authController.myUser.value.name == null?"Mark":authController.myUser.value.name!,style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),overflow: TextOverflow.ellipsis,maxLines: 1,)
                          ],
                        ),
                      )

                    ],
                  )),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [

                buildDrawerItem(title: 'Payment History',onPressed: (){}),
                buildDrawerItem(title: 'Ride History',onPressed: (){},isVisible: true),
                buildDrawerItem(title: 'Invite Friends',onPressed: (){}),
                buildDrawerItem(title: 'Promo Codes',onPressed: (){}),
                buildDrawerItem(title: 'Settings',onPressed: (){}),
                buildDrawerItem(title: 'Support',onPressed: (){}),
                buildDrawerItem(title: 'Log Out',onPressed: (){}),

              ],
            ),
          ),

          Spacer(),

          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: Column(
              children: [
                buildDrawerItem(title: 'Do more',onPressed: (){},fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.15),height: 20),
                const SizedBox(height: 20,),

                buildDrawerItem(title: 'Get food delivery',onPressed: (){},fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.15),height: 20),
                buildDrawerItem(title: 'Make money driving',onPressed: (){},fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.15),height: 20),
                buildDrawerItem(title: 'Rate us on store',onPressed: (){},fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.15),height: 20,),

              ],
            ),
          ),
          const SizedBox(height: 20,),


        ],
      ),
    );
  }
}
