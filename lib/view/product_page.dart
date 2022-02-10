import 'package:flutter/material.dart';
import 'package:torulota/view/single_product_page.dart';


class Products extends StatefulWidget {
  //const Products({Key? key}) : super(key: key);
  var _product;
  Products(this._product);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  // List product = [];
  //
  // fetchproductdetails()async{
  //   QuerySnapshot qn = await FirebaseFirestore.instance.collection("products").get();
  //   for(int i=0; i<qn.docs.length; i++){
  //     product.add(
  //         {
  //           "product-img":qn.docs[i]["product-img"],
  //           "product-name":qn.docs[i]["product-name"],
  //           "product-price":qn.docs[i]["product-price"],
  //           "product-type":qn.docs[i]["product-type"],
  //           "product-height":qn.docs[i]["product-height"],
  //           "product-description":qn.docs[i]["product-description"],
  //         });
  //   }
  // }
@override
  void initState() {
    //fetchproductdetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context)=>IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Color(0xff484848),),
          ),
        ),
        title: Text('All Products',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 200),
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct(widget._product[index])));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(width: 1, color: Colors.grey.shade300)),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  widget._product[index]["product-img"],
                                  height: 100,
                                  width: 100,
                                ),
                                Text(
                                  widget._product[index]["product-name"],
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget._product[index]["product-type"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          widget._product[index]["product-price"],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: IconButton(
                                            onPressed: () {

                                            },
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
                            ),
                            Positioned(
                                child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.red.shade100),
                                        borderRadius: BorderRadius.circular(10)),
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
                      ),
                    );
                  },
                  itemCount: widget._product.length),
            ),
          )
        ],
      ));
  }
}