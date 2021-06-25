import 'package:apni_kaksha/cart_page.dart';
import 'package:apni_kaksha/data_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin{
  bool isColapsed = true;
  late TabController _tabController;
  final duration = const Duration(milliseconds: 300);
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  Animation<double>? _menuScaleAnimation;
  Animation<Offset>? _slideAnimation;
  List<Model> carItems = [];

  GroceryData methods = GroceryData();
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _controller = AnimationController(vsync: this, duration:duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller!);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0,0)).animate(_controller!);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller!);
  }

  @override
  void dispose(){
    _controller!.dispose();
    super.dispose();
  }
  

Widget shopPage(context, TabController _tabController){
  Size size = MediaQuery.of(context).size;
  return AnimatedPositioned(
    duration: Duration( milliseconds:300),
    top: 0,
    bottom: 0,
    left: isColapsed ? 0 : 0.6 * size.width,
    right: isColapsed ? 0 :-0.4 * size.width,
      child: ScaleTransition(
        scale: _scaleAnimation!,
              child: Material(
          animationDuration:Duration( milliseconds:300),
          borderRadius: BorderRadius.circular(20),
        elevation: 10,
        color: Colors.lightGreen,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
                  child: Column(
                children:[
                   Container(
              padding: EdgeInsets.only(left:10, right: 10, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100))
              ),
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(isColapsed){
                                _controller!.forward();
                              }else{
                                _controller!.reverse();
                              }
                              isColapsed = !isColapsed;
                            });
                          },
                          child: Icon(Icons.menu, color: Colors.white, size: 30,)),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                            child: Text("Delivery Location", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ), textAlign: TextAlign.left,),
                          ),
                        Container(
                          child: Text("B-52 Gongotri Apartment, Kolkata", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
                        ),]),
                      ),
                        ]),
                      Stack(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.shopping_cart,
                            color: Colors.white,),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CartPage(cartItems: carItems,)));
                              },
                          ),
                          carItems.length >0?
                          Positioned(
                              child: Stack(
                                children: <Widget>[
                                  Icon(
                                      Icons.brightness_1,
                                      size: 20.0, color: Colors.green[800]),
                                   Positioned(
                                      top: 3.0,
                                      right: 4.0,
                                      child: Center(
                                        child: Text( carItems.length.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      )),
                                ])
                                ): SizedBox()
                                ])
                    ],
                  ),
                  _searchField(context),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage('assets/images/vegiesJPG.JPG', ), fit: BoxFit.cover),
                    ),
                  ),
                ])
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.only( bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100))
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
                    child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20), topLeft: Radius.circular(-20)),
                ),
                tabs: [
                 Tab(
                         text: "TODAY OFFERS",
                         ),
                      Tab(
                         text: "CATEGORIES",
                         ),
                 Tab(
                         text: "FAVOURITES",
                         ),
              ]
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
                    child: TabBarView(
                controller: _tabController,
                children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: methods.data.length,
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
                                              image: DecorationImage(image: AssetImage(methods.data.elementAt(i).imageUrl!, ), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text( '\$'+ methods.data.elementAt(i).price!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(height: 3),
                                      Text( methods.data.elementAt(i).name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                      SizedBox(height: 3),
                                      Container(
                                        width: 200,
                                        child: Text( methods.data.elementAt(i).description!, style: TextStyle(color: Colors.grey),)),
                                      SizedBox(height: 3),
                                      Text( methods.data.elementAt(i).address!),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[
                                           Text(methods.data.elementAt(i).quantity!.toString() + 'kg',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                           SizedBox(width: 50),
                                           Container(
                                             decoration: BoxDecoration(
                                               color: Colors.grey[200],
                                               borderRadius: BorderRadius.circular(20)
                                             ),
                                             child: TextButton(onPressed: (){
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 SnackBar(
                                                   content: Text(methods.data.elementAt(i).name! + " added to cart..", style: TextStyle(fontWeight: FontWeight.bold),),
                                                   duration: Duration(milliseconds: 700),
                                                   backgroundColor: Colors.lightGreen,
                                                   ));
                                               setState(() {
                                                 carItems.add(methods.data.elementAt(i));
                                               });
                                             }, child: Text("ADD", style: TextStyle(color: Colors.orange),)))
                                        ]),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        ),
                       ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: methods.data.length,
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
                                              image: DecorationImage(image: AssetImage(methods.data.elementAt(i).imageUrl!, ), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text( '\$'+ methods.data.elementAt(i).price!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(height: 3),
                                      Text( methods.data.elementAt(i).name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                      SizedBox(height: 3),
                                      Container(
                                        width: 200,
                                        child: Text( methods.data.elementAt(i).description!, style: TextStyle(color: Colors.grey),)),
                                      SizedBox(height: 3),
                                      Text( methods.data.elementAt(i).address!),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[
                                           Text(methods.data.elementAt(i).quantity!.toString() + 'kg',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                           SizedBox(width: 50),
                                           Container(
                                             decoration: BoxDecoration(
                                               color: Colors.grey[200],
                                               borderRadius: BorderRadius.circular(20)
                                             ),
                                             child: TextButton(onPressed: (){
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 SnackBar(
                                                   content: Text(methods.data.elementAt(i).name! + " added to cart..", style: TextStyle(fontWeight: FontWeight.bold),),
                                                   duration: Duration(milliseconds: 700),
                                                   backgroundColor: Colors.lightGreen,
                                                   ));
                                               setState(() {
                                                 carItems.add(methods.data.elementAt(i));
                                               });
                                             }, child: Text("ADD", style: TextStyle(color: Colors.orange),)))
                                        ]),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        ),
                       ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: methods.data.length,
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
                                              image: DecorationImage(image: AssetImage(methods.data.elementAt(i).imageUrl!, ), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text( '\$'+ methods.data.elementAt(i).price!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(height: 3),
                                      Text( methods.data.elementAt(i).name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                      SizedBox(height: 3),
                                      Container(
                                        width: 200,
                                        child: Text( methods.data.elementAt(i).description!, style: TextStyle(color: Colors.grey),)),
                                      SizedBox(height: 3),
                                      Text( methods.data.elementAt(i).address!),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[
                                           Text(methods.data.elementAt(i).quantity!.toString() + 'kg',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                           SizedBox(width: 50),
                                           Container(
                                             decoration: BoxDecoration(
                                               color: Colors.grey[200],
                                               borderRadius: BorderRadius.circular(20)
                                             ),
                                             child: TextButton(onPressed: (){
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                 SnackBar(
                                                   content: Text(methods.data.elementAt(i).name! + " added to cart..", style: TextStyle(fontWeight: FontWeight.bold),),
                                                   duration: Duration(milliseconds: 700),
                                                   backgroundColor: Colors.lightGreen,
                                                   ));
                                               setState(() {
                                                 carItems.add(methods.data.elementAt(i));
                                               });
                                             }, child: Text("ADD", style: TextStyle(color: Colors.orange),)))
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
                 ] ),
        ),
    ),
      ),
  );
}

Widget _searchField(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search for Product",
          icon:  Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search, color: Colors.green )), 
      ),
    ));
  }


Widget menu(context){
  return SlideTransition(
    position: _slideAnimation!,
      child: ScaleTransition(
        scale: _menuScaleAnimation!,
              child: Align(
        alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
                      child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Sepator(title: "FOR YOU",),
            DrawerItem(title: "RECOMMENDATION", icon: Icons.verified, func: (){},),
            DrawerItem(title: "NEW", icon: Icons.new_label, func: (){},),
            DrawerItem(title: "SPECIALS", icon: Icons.adb, func: (){},),
            Sepator(title: "BROWSE",),
            DrawerItem(title: "BABY", icon: Icons.bedroom_baby, func: (){},),
            DrawerItem(title: "BAKING", icon: Icons.cake, func: (){},),
            DrawerItem(title: "BREAKFAST", icon: Icons.breakfast_dining,func: (){},),
            DrawerItem(title: "DRINKS", icon: Icons.cloud_upload, func: (){},),
            DrawerItem(title: "HEALTH", icon: Icons.health_and_safety, func: (){},),
            DrawerItem(title: "FRUIT", icon: Icons.free_breakfast, func: (){},),
            DrawerItem(title: "VEGETABLES", icon: Icons.health_and_safety, func: (){},),
        ],
        ),
          ),
    ),
      ),
  );
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          menu(context),
          shopPage(context, _tabController)
        ],
      ),
      
    );

}
}
class Sepator extends StatelessWidget {
  final String? title;
  const Sepator({
    Key? key,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
        child: Text(title!, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function func;
  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        func();
      },
          child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15, vertical: 13),
            child: Icon(icon, color: Colors.white,)),
          Text(title!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),)
        ],
      ),
    );
  }
}