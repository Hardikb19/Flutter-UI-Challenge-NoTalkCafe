import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'dart:math' as math;

void main() => runApp(FlutterUI());

class FlutterUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
        accentColor: Colors.transparent,
        backgroundColor: Colors.grey,
        fontFamily: 'Cabin'
      ),
      home:  MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}


int diffval = 2;
class _MenuPageState extends State<MenuPage> {
  var currentPage = imagespizza.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: imagespasta.length,keepPage: false);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.black,
                (diffval==1)?Colors.greenAccent:(diffval==2)?Colors.red:Colors.blueGrey,
                Colors.black,
                Colors.black,
                Colors.black,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              tileMode: TileMode.clamp)),

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('No Talk Cafe',style: activeText(),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 10.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
               Container(
                margin: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          diffval = 1;
                          //currentPage = imagespizza.length - 1.0;
                        });
                        MaterialPageRoute(builder: (context)=>build(context));
                        print(diffval);
                      },
                      child: Text(
                          'Pizza',
                          style: (diffval==1)?activeText():inactiveText(),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          diffval = 2;
                          //currentPage = imagesBurger.length - 1.0;
                        });
                        MaterialPageRoute(builder: (context)=>build(context));
                        print(diffval);
                      },
                      child: Text(
                          'Burger',
                          style: (diffval==2)?activeText():inactiveText(),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          diffval = 3;
                          currentPage = imagespasta.length - 0.0;
                        });
                        MaterialPageRoute(builder: (context)=>build(context));
                        print(diffval);
                      },
                      child: Text(
                          'Pasta',
                          style: (diffval==3)?activeText():inactiveText(),
                      ),
                    )
                  ],
                )
              ),
              Stack(
                children: <Widget>[
                  (diffval == 1)?CardScrollWidget(currentPage,imagespizza,titlepizza):(diffval == 2)?CardScrollWidget(currentPage,imagesBurger,titleburger):CardScrollWidget(currentPage,imagespasta,titlepasta),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: imagespasta.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
             Container(
               alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text((diffval == 1)?'Pizza':(diffval == 2)?'Burger':'Pasta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                      icon: Icon(
                        (diffval == 1)?FontAwesomeIcons.pizzaSlice:(diffval == 2)?FontAwesomeIcons.hamburger:FontAwesomeIcons.pepperHot,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}


var cardAspectRatio = 12.0 / 20.0;
var widgetAspectRatio = cardAspectRatio*1.25;

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  List<String> images;
  List<String> title;

  CardScrollWidget(this.currentPage,this.images,this.title);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {

        var primaryCardLeft = 50.0;
        var horizontalInset = primaryCardLeft;

        List<Widget> cardList = new List();
        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding + math.max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 20: 1),0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * math.max(-delta, 0.0),
            bottom: padding + verticalInset * math.max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0)
                  ),
                border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                    style: BorderStyle.solid
                  ),
                  color: Colors.white,
                  boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0)
                    ]
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0)
                  )
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0)
                          ),
                        child: Image.asset(images[i], fit: BoxFit.cover),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)
                                    ),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.black.withOpacity(0.4),
                                      Colors.black.withOpacity(0.3),
                                      Colors.black.withOpacity(0.4),                                      
                                      Colors.black.withOpacity(0.3),
                                      Colors.black.withOpacity(0.4),
                                    ],
                                    tileMode: TileMode.clamp
                                  )
                                ),
                                child: Text(title[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.orangeAccent,
                                          blurRadius: 3.0,
                                          offset: Offset(2.0, 3.0)
                                        )
                                        ],
                                        fontSize: 25.0,)
                                      ),
                              )
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.black,blurRadius: 2.0)
                                    ],
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(20.0)),
                                  child: Text("Add to Basket",
                                      style: TextStyle(color: Colors.black)),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}


TextStyle inactiveText(){
  return TextStyle(
    fontSize: 20.0,
    color: Colors.white54
  );
}

TextStyle activeText(){
  return TextStyle(
    fontSize: 30.0,
    color: Colors.white
  );
}

List<String> imagespasta = [
  'speggod.jpg',
  'pasta1.jpg',
  'pasta2.jpg',
];

List<String> imagespizza = [
  'burst.jpg',
  'burst2.jpg',
  'burst3.jpg',
];

List<String> imagesBurger = [
  'burger-king.jpg',
  'burger-triple-large.png',
  'Bacon-Cheesy-1.jpg'
];


List<String> titleburger = [
  'Ham Chesse Burgs',
  'Paneer Roast Burgorilla',
  'Bacon Monger',
];

List<String> titlepasta = [
  'Red Paradise',
  'Mac n Chessey',
  'Speg-o-god',
];

List<String> titlepizza = [
  'Pepper-on-ei',
  'Veg Junglee',
  'Cheesey Burrst',
];


List<String> food = [
  'Pizza',
  'Pasta',
  'Burger',
];