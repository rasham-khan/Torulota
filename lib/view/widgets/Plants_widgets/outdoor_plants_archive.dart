import 'package:flutter/material.dart';
import 'package:torulota/model/product.dart';

class OutdoorArchive extends StatelessWidget {
  OutdoorArchive({Key? key}) : super(key: key);
  final _outdoorplantlist = Product.generateOutDoorProducts();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Outdoor Plants',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),),
            )
        ),
        Expanded(
          flex: 10,
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
                  var outdoor = _outdoorplantlist[index];
                  var price = outdoor.price;
                  return InkWell(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProduct()));
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
                              Hero(
                                tag: 'product',
                                child: Image.asset(
                                  outdoor.url,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Text(
                                outdoor.name,
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
                                        outdoor.type,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        '$price৳',
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
                itemCount: _outdoorplantlist.length),
          ),
        )
      ],
    );
  }
}
