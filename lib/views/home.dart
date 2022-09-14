import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _mapStyle;


  @override
  void initState() {
    super.initState();

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
      child: Container(
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
                image: DecorationImage(
                  image: AssetImage('assets/person.png'),
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
                          text: 'Mark',
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
      ),
    );
  }


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

          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffA7A7A7)),
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
}
