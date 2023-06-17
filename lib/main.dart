
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yummy_express/constants/theme.dart';
import 'package:yummy_express/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:yummy_express/firebase_helper/firebase_options/firebase_options.dart';
import 'package:yummy_express/provider/app_provider.dart';
import 'package:yummy_express/screens/auth_ui/welcome/welcome_screen.dart';
import 'package:yummy_express/screens/custom_bottom_bar/custom_bar_screen.dart';
import 'package:yummy_express/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Yummy Express',
       theme: themeData,
       debugShowCheckedModeBanner: false,
       home: StreamBuilder(
         stream: FirebaseAuthHelper.instance.getAuthChange,
           builder: (context, snapshot) {
           if (snapshot.hasData) {
             return const CustomBottomBarScreen();
           }
           return const WelcomeScreen();
           }
           ),
      ),
    );
  }
}
