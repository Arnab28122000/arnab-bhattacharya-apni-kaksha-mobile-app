import 'package:apni_kaksha/data_model.dart';
import 'package:flutter/material.dart';
class CartPage extends StatefulWidget {
  final List<Model>? cartItems;
  const CartPage({
     Key? key ,
     required this.cartItems
     }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Model>? tempCartItems=[];
  int? price=0;


  @override
  void initState() {
    setState(() {
      tempCartItems = widget.cartItems;  
    });
    
    widget.cartItems!.forEach((element) { 
      setState(() {
        price= price! + element.price!;  
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,),
        onPressed: ()=>Navigator.of(context).pop(),
        ), 
        title: Padding(
          padding: EdgeInsets.only(left: 80),
          child: Text("Cart page")),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                                      child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Total Price:", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15)),
                        )
                    ),
                  ),
                  Card(
                    child: Text('\$'+price.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
            ),
            ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: tempCartItems!.length,
                        itemBuilder: (_, int i){
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20)
                                                        ),
                              elevation: 2,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                    child: Container(
                                      width: MediaQuery.of(context).size.width *0.32,
                                      height: 150,

                                      decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(image: AssetImage(tempCartItems!.elementAt(i).imageUrl!, ), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text( '\$'+ tempCartItems!.elementAt(i).price!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(height: 3),
                                      Text( tempCartItems!.elementAt(i).name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                      SizedBox(height: 3),
                                      Container(
                                        width: 200,
                                        child: Text( tempCartItems!.elementAt(i).description!, style: TextStyle(color: Colors.grey),)),
                                      SizedBox(height: 3),
                                      Text( tempCartItems!.elementAt(i).address!),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[
                                           Text(tempCartItems!.elementAt(i).quantity!.toString() + 'kg',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                           SizedBox(width: 50),
                                           Container(
                                             decoration: BoxDecoration(
                                               color: Colors.grey[200],
                                               borderRadius: BorderRadius.circular(20)
                                             ),
                                             child: TextButton(onPressed: (){
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 SnackBar(
                                                   content: Text(tempCartItems!.elementAt(i).name! + " removed from cart..", style: TextStyle(fontWeight: FontWeight.bold),),
                                                   duration: Duration(milliseconds: 700),
                                                   backgroundColor: Colors.lightGreen,
                                                   ));
                                               setState(() {
                                                 price = price!-tempCartItems!.elementAt(i).price!;
                                                 tempCartItems!.removeAt(i);
                                               });
                                                
                                             }, child: Text("REMOVE", style: TextStyle(color: Colors.orange),)))
                                        ]),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        ),
          ],
        ),
      ),
    );
  }
}