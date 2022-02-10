import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:torulota/view/auth/register_page.dart';

import 'package:torulota/view/homepage.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Torulota());
}
class Torulota extends StatelessWidget {
  const Torulota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff32A060),
        accentColor: Color(0xff32A060)
      ),
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  List product = [];

  fetchproductdetails()async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("products").get();
    for(int i=0; i<qn.docs.length; i++){
      product.add(
          {
            "product-img":qn.docs[i]["product-img"],
            "product-name":qn.docs[i]["product-name"],
            "product-price":qn.docs[i]["product-price"],
            "product-type":qn.docs[i]["product-type"],
            "product-height":qn.docs[i]["product-height"],
            "product-description":qn.docs[i]["product-description"],
          });
    }
  }
  usercheck(){
    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register(product)));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(product)));
      }
    });
  }
  @override
  void initState() {
    fetchproductdetails();
    usercheck();
    Timer(Duration(seconds: 3), (){usercheck();});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.gif'),
            Text('TORULOTA',style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 30,
                color: Colors.green
            ),)
          ],
        ),
      ),
    );
  }
}
