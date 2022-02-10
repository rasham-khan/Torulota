import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:torulota/view/cart.dart';
import 'package:torulota/view/single_product_page.dart';
import 'widgets/Drawer/drawer_screen.dart';

class HomePage extends StatefulWidget {
  var _product;
  HomePage(this._product);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(widget._product),
      drawerScrimColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Builder(builder: (ctx) {
          return IconButton(
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              splashRadius: 25,
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
              icon: Icon(
                Icons.menu_outlined,
                color: Color(0xff484848),
              ));
        }),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(color: Color(0xff484848)),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users-form-data")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.data ==null){
                        return CircularProgressIndicator(color: Theme.of(context).primaryColor,);
                      }else{
                        return RichText(
                          overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color(0xff484848)
                              ),
                                children: [
                              TextSpan(text: snapshot.data["name"])
                            ]));
                      }
                    }
                    )
              ],
            ),
            Text(
              'What plant do you want?',
              style: TextStyle(
                  color: Color(0xff484848),
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              splashRadius: 25,
              icon: Icon(
                Icons.search,
                color: Color(0xff484848),
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
              },
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              splashRadius: 25,
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: Color(0xff484848),
              )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Top',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              //Toprated(),
              Container(
                height: 300,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(widget._product[index])));
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
                                            Text(widget._product[index]["product-name"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),),
                                            SizedBox(height: 5,),
                                            Text(widget._product[index]["product-type"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 12),),
                                            SizedBox(height: 5,),
                                            Text(widget._product[index]["product-price"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 12)),
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
                                child: Image.network(widget._product[index]["product-img"],height: 250,width: 200,)
                            )
                          ],
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_,index)=>SizedBox(width: 15),
                    itemCount: widget._product.length
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Plant Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  _category(
                      image: 'assets/inDoorPlants/Snake Plant Laurentii.png',
                      text: 'Indoor Plant',
                      fct: () {}),
                  SizedBox(
                    width: 10,
                  ),
                  _category(
                      image: 'assets/outDoorPlants/agava.png',
                      text: 'Outdoor Plant',
                      fct: () {}),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Featured products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              //IndoorPlants(),
              Container(
                height: 250,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {

                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(widget._product[index])));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.grey.shade300)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    widget._product[index]["product-img"],
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
                                  Text(widget._product[index]["product-name"],style: TextStyle(
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
                                          Text(widget._product[index]["product-type"],style: TextStyle(
                                              fontWeight: FontWeight.w500
                                          ),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(widget._product[index]["product-price"],style: TextStyle(
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
                    itemCount: widget._product.length),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _category(
      {required String image, required String text, required Function fct}) {
    return Expanded(
        flex: 1,
        child: InkWell(
          onTap: fct(),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Column(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xffE5ECDC),
                      ),
                      Positioned(
                          bottom: 0,
                          top: -10,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            image,
                            height: 300,
                            width: 150,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
