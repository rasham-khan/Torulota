import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:torulota/view/single_product_page.dart';

class OutdoorPlants extends StatefulWidget {
  OutdoorPlants({Key? key}) : super(key: key);

  @override
  State<OutdoorPlants> createState() => _OutdoorPlantsState();
}

class _OutdoorPlantsState extends State<OutdoorPlants> {
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
      height: 250,
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(product[index])));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey.shade300)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          product[index]["product-img"],
                          height: 150,
                          width: 150,
                        ),
                        Positioned(
                            child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red.shade100),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: IconButton(
                                    onPressed: () {},
                                    splashColor: Colors.red.withOpacity(0.3),
                                    splashRadius: 25,
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                      size: 15,
                                    )
                                )
                            )
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(product[index]["product-name"],style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product[index]["product-type"],style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(product[index]["product-price"],style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: IconButton(
                                    onPressed: () {},
                                    splashColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    splashRadius: 25,
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.grey,
                                      size: 15,
                                    )))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, index) => SizedBox(width: 15),
          itemCount: product.length),
    );
  }
}
