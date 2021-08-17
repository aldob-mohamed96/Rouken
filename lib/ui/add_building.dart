import 'package:flutter/material.dart';
 

class add_building extends StatefulWidget {
  @override
  _add_buildingState createState() => _add_buildingState();
}
int typeofadd=1;String titlepbar='اضافه عقارات للبيع';String imageback='assets/img/img4.jpg';
class _add_buildingState extends State<add_building>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        ////////////////////////////////////////////////////////////////////////////////////////////////
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height >= 600.0
                        ? MediaQuery.of(context).size.height
                        : 600.0,
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                              child: new Container(
                            child: new IconButton(
                              onPressed: () =>
                                  {Navigator.of(context).pop()},
                              icon: new Icon(Icons.close),
                              iconSize: 50,
                              color: Colors.black,
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Center(child: new Card_of_selling(text: 'اضافه عقار جديد',color: Colors.grey,)),
                          SizedBox(
                            height: 25,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new InkWell(
                                   onTap: (){
                                     setState(() {
                                      typeofadd=3; 
                                      imageback='assets/img/img4.jpg';
                                      titlepbar='اضافه عقارات للايجار ';
                                     });
                                     Navigator.of(context)
                                            .pushNamed('/page_of_adding');},
                                  child: new Four_cards(
                                    text1: 'عقارات',
                                    text2: 'للايجار',
                                    img: 'assets/img/img4.jpg',

                                  )),
                              new InkWell(
                                  onTap: ()  {Navigator.of(context)
                                            .pushNamed('/page_of_adding');
                                            setState(() {
                                              imageback='assets/img/img2.jpg';
                                             typeofadd=4;
                                              titlepbar='اضافه عقارات للبيع';
                                            });},
                                  child: new Four_cards(
                                    text1: 'عقارات',
                                    text2: 'للبيع',
                                    img: 'assets/img/img2.jpg',
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new InkWell(
                                  onTap: ()  {
                                    setState(() {
                                             typeofadd=1;
                                             imageback='assets/img/img1.jpg';
                                              titlepbar='اضافه سكن مشترك';
                                            });
                                    Navigator.of(context)
                                            .pushNamed('/page_of_adding');
                                  },
                                  child: new Four_cards(
                                    text1: 'سكن',
                                    text2: 'مشترك',
                                    img: 'assets/img/img1.jpg',
                                  )),
                              new InkWell(
                                  onTap: ()  {setState(() {
                                             typeofadd=2;
                                             imageback='assets/img/img3.jpg';
                                              titlepbar='اضافه عقارات للاستثمار';
                                            });
                                    Navigator.of(context)
                                            .pushNamed('/page_of_adding');
                                  },
                                  child: new Four_cards(
                                    text1: 'عقارات',
                                    text2: 'للاستثمار',
                                    img: 'assets/img/img3.jpg',
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    )))
        /////////////////////////////////////////////////////////////////////////////
        );
  }
}

class Four_cards extends StatelessWidget {
  final String text1;
  final String text2;
  final String img;

  const Four_cards({
    this.img,
    this.text1,
    this.text2,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  new Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          borderOnForeground: false,
          child: Container(
           
              alignment: Alignment.center,
             width: 140,
              height: 140,
             decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img)),
          borderRadius: const BorderRadius.all(const Radius.circular(5)),
        ),
      
                      child: new Stack(
               
              children: <Widget>[
                 
                new Center(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(text1,
                        style: TextStyle(
                            fontFamily: 'DroidSansArabic',
                            fontSize: 20,
                            color: Colors.white)),
                    new Text(text2,
                        style: TextStyle(
                            fontFamily: 'DroidSansArabic',
                            fontSize: 20,
                            color: Colors.white)),
                  ],
                )),
              ],
            ),
          ),
        );
  }
}

class Card_of_selling extends StatelessWidget {
  final String text;
  final Color color;
  const Card_of_selling({
    this.color,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Text(text,
            style: TextStyle(
                fontFamily: 'DroidSansArabic',
                fontSize: 30,
                color: color)));
  }
}
