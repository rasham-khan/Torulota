import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:torulota/view/single_product_page.dart';

class Toprated extends StatefulWidget {
  Toprated({Key? key}) : super(key: key);

  @override
  State<Toprated> createState() => _TopratedState();
}

class _TopratedState extends State<Toprated> {
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
@override
  void initState() {
    fetchproductdetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(product[index])));
              },
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width/2.5,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.5)
                        ]
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product[index]["product-name"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),),
                                  SizedBox(height: 5,),
                                  Text(product[index]["product-type"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 12),),
                                  SizedBox(height: 5,),
                                  Text(product[index]["product-price"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 12)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                  child: IconButton(
                                    alignment: Alignment.center,
                                      onPressed: (){},
                                      splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                      splashRadius: 25,
                                      icon: Icon(Icons.add_shopping_cart,color: Colors.grey,size: 15,)
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                      right: -25,
                      child: Image.network(product[index]["product-img"],height: 250,width: 200,)
                  )
                ],
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_,index)=>SizedBox(width: 15),
          itemCount: product.length
      ),
    );
  }
}