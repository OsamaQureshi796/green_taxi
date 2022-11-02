import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_taxi/views/decision_screen/decission_screen.dart';
 import 'package:firebase_core/firebase_core.dart';
 import 'controller/auth_controller.dart';
import 'firebase_options.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
     AuthController authController = Get.put(AuthController());
    authController.decideRoute();
    final textTheme = Theme.of(context).textTheme;

    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
      ),
      home:   DecisionScreen(),
    );
  }
}
