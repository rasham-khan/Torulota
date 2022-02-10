
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatefulWidget {
  var _product;
  SingleProduct(this._product);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  addtocart()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-cart");
    return _collectionRef.doc(currentUser!.email).collection("items").doc().set(
        {
          "name":widget._product["product-name"],
          "price":widget._product["product-price"],
          "image":widget._product["product-img"],
        }
    ).then((value) => print("added to cart"));
  }
  addtofav()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-favourite");
    return _collectionRef.doc(currentUser!.email).collection("items").doc().set(
        {
          "name":widget._product["product-name"],
          "price":widget._product["product-price"],
          "image":widget._product["product-img"],
        }
    ).then((value) => print("added to cart"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,)
                      ),
                      SizedBox(height: 0,),
                      Text(widget._product["product-name"],style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 15,),
                      Text(widget._product["product-type"],style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18
                      ),),
                      SizedBox(height: 20,),
                      Text('Price',style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 5,),
                      Text(widget._product["product-price"]+"৳",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),),
                      SizedBox(height: 15,),
                      Text('Height',style: TextStyle(
                          fontSize: 15,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.w500
                      )),
                      SizedBox(height: 5,),
                      Text(widget._product["product-height"]+"cm",style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      )),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Description',style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 10,),
                          Text(widget._product["product-description"]),
                          MaterialButton(
                            minWidth: double.infinity,
                            onPressed: (){
                              addtocart();
                            },
                            child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                            color: Theme.of(context).primaryColor,
                          ),
                          FlatButton(
                            minWidth: double.infinity,
                            onPressed: (){
                              addtofav();
                            },
                            child: Text("Add to Favourite",style: TextStyle(color: Colors.white),),
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -300,
                        right: -100,
                        child: Image.network(widget._product["product-img"],width: 350,height: 350,)
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
