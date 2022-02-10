import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:torulota/view/auth/login.dart';
import 'package:torulota/view/auth/register_page.dart';
import 'package:torulota/view/product_page.dart';
import 'package:torulota/view/profile_page.dart';

import '../../favourite.dart';
class DrawerWidget extends StatefulWidget {
  var _product;
  DrawerWidget(this._product);
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  logout()async{
    await FirebaseAuth.instance.signOut();
  }
  @override
  void initState() {
    //fetchproductdetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: double.infinity,
      color: Colors.grey.shade200,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Icon(Icons.close)),
                RotatedBox(
                  quarterTurns: 3,
                  child: TextButton(
                      child: Text(
                        'Products',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Products(widget._product)));
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: TextButton(
                      child: Text(
                        'Profile',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                      }
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: TextButton(
                      child: Text(
                        'Favourite',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Favourite()));
                      }
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users-cart").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
                        if(snapshot.data == null){
                          return RotatedBox(
                            quarterTurns: 3,
                            child: TextButton(
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register(widget._product)));
                                }
                            ),
                          );
                        }else{
                          return RotatedBox(
                            quarterTurns: 3,
                            child: TextButton(
                                child: Text(
                                  'Logout',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                onPressed: () {
                                  logout();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(widget._product)));
                                }
                            ),
                          );
                        };
                    }
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                    splashRadius: 1,
                    onPressed: () {},
                    icon: Icon(Icons.contact_support_outlined,
                        color: Color(0xff484848))),
                IconButton(
                    splashRadius: 1,
                    onPressed: () {},
                    icon: Icon(Icons.settings, color: Color(0xff484848))),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
