
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_couture/account_type_screen.dart';
import 'package:flutter_couture/customer_signup_screen.dart';
import 'package:flutter_couture/firebase_options.dart';
import 'package:flutter_couture/login_screen.dart';
import 'package:flutter_couture/tailor_signup_screen.dart';


  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("test").doc("connection_check").set({"status": "connected"});
    print("✅ Firestore connection successful!");
  } catch (e) {
    print("❌ Firestore connection failed: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: const LoginScreen(),
      routes: {
        'loginScreen': (context) => const LoginScreen(),
        'accountTypeScreen': (context) => const AccountTypeScreen(),
        'signupscreenfortailor': (context) => const TailorSignUpScreen(),
        'signupscreenforcustomer' :(context) => const CustomerSignUpScreen(),
      },
    );
  }
}
