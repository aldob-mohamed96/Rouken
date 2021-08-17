import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_apps/ui/webview.dart';
import 'package:flutter_apps/ui/see_all_building.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

int on_clicked_catogray_id = 1;
String name_cat_arabic = '';

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  final List<catogray> catogry = [];
  final List<advertis> advertisss = [];
 String url='https://rouckn.com/api/v1/home';
  Future<List<catogray>> _type_catogray() async {
    try{
     
       var data = await http.get(Uri.encodeFull(url))
        .catchError((onError) {
      new Text('no catogray');

    }).catchError((onError){
    
    });
   
    var jsondata = json.decode(data.body);
    catogry.clear();
    for (var u in jsondata['categories']) {
      catogray user = new catogray(

          u['id'],
          u['arabic_name'].toString(),
          u['english_name'].toString(),
          u['image'].toString(),
          u['notes'].toString(),
          u['created_at'].toString(),
          u['updated_at'].toString(),
          u['logo'].toString());

      catogry.add(user);
    
    }

//  await new Future.delayed(new Duration(seconds: 5));
    return catogry;
    }
    catch(Error)
    {
 
       Toast.show("no data ", context); 
    }
   
  }

  Future<List<advertis>> _t() async {
    try{
    String url='https://rouckn.com/api/v1/adverts';
    var data = await  http.get(Uri.encodeFull(url))
    
    .catchError((onError) {
      new Text('no catogray');
    }).then((r){
     
     
    var jsondata = json.decode(r.body);
   
    advertisss.clear();
    for (var u in jsondata['adverts']) {
      advertis user = new advertis(
        u['id'],
        u['name'].toString(),
        u['logo'].toString(),
        u['link'].toString(),
        u['created_at'].toString(),
        u['updated_at'].toString(),
      );
      advertisss.add(user);

    }

//  await new Future.delayed(new Duration(seconds: 5));


    });
    }
    catch(Error)
    {
      print(Error.toString());
        
    }
        return advertisss;
}

  Widget type_catergory(BuildContext context, AsyncSnapshot snapshot) {
    List<catogray> values_cat = snapshot.data;
    return new Container(
      // color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 5.0, right: 5),

      child: ListView.builder(
        itemCount: values_cat.length,
        scrollDirection: Axis.horizontal,
        primary: true,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                on_clicked_catogray_id = values_cat[index].id;
                name_cat_arabic = values_cat[index].arabic_name;
              });

              Navigator.of(context).pushNamed('/sub_cat');
            },
            child: new Card(

              clipBehavior: Clip.hardEdge,
              shape: new RoundedRectangleBorder(

                borderRadius: new BorderRadius.circular(10.0,)),
              elevation: 1.0,

              borderOnForeground: true,
              margin: EdgeInsets.all(5),
              semanticContainer: true,
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 7,
                    height: 80,
                    fit: BoxFit.contain,
                    repeat: ImageRepeat.noRepeat,
                    imageUrl: values_cat[index].logo.toString(),
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        new Icon(Icons.question_answer),
                  ),
                  new SizedBox(
                    height: 5,
                    width: 120,

                  ),
                  new Text(values_cat[index].arabic_name.toString(),
                      style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 17,
                          color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget createlistview(BuildContext context, AsyncSnapshot snapshot) {
    List<advertis> values = snapshot.data;

    return new Container(
        height: 250,
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: values.length<5?values.length:5,
            // itemExtent: 10.0,
            // reverse: true, //makes the list appear in descending order
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 20.0,
                padding: EdgeInsets.all(2),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  elevation: 1.0,
                  borderOnForeground: true,
                  margin: EdgeInsets.all(2),
                  semanticContainer: true,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          urlwebview = values[index].link.toString();
                        });
                        Navigator.of(context).pushNamed('/webview');
                      },
                      child: new CachedNetworkImage(
                        width: MediaQuery.of(context).size.width - 10.0,
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                        imageUrl: values[index].image.toString(),
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            ),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.question_answer),
                      )),
                ),
              );
            }));
  }


  Widget createlistview_error(BuildContext context,double height,double width,String message) {
   

    return new Container(
        height: height,
        width:width,
        child: 
                Card(
                  clipBehavior: Clip.hardEdge,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  elevation: 1.0,
                  borderOnForeground: true,
                  margin: EdgeInsets.all(2),
                  semanticContainer: true,
                  child: Align(alignment: Alignment.center,child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                         Icon(Icons.error_outline,size: 50,),
                         new Text(message)
                      ],))
              
              
            ));
  }
  

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _type_catogray();

    _t();
  }

  @override
  Widget build(BuildContext context) {

    var futurbuilder_catergory = new FutureBuilder(
      future: _type_catogray(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('status : ' + snapshot.connectionState.toString());
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                ));
          case ConnectionState.done:
            if (snapshot.hasError||snapshot.hasData==false) return createlistview_error(context,50, MediaQuery.of(context).size.width/3,"no Catgory found");
            return type_catergory(context, snapshot);
        }
        return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
      },
    );
    var futurbuilder = new FutureBuilder(
      future: _t(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) 
            return  createlistview_error(context,250,
             MediaQuery.of(context).size.width-20,"no Advertices found");
            return createlistview(context, snapshot);
        }
        return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
      },
    );
    return Scaffold(
       bottomNavigationBar: new BottomAppBar(
           clipBehavior: Clip.hardEdge,
           elevation: .1,
           notchMargin:7.0,
           color:
          Colors.blueAccent,child: new Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
         child:  new MaterialButton(
                    height: 65,
                    color: Themes.Colors.bulecolors,
                    textColor: Colors.white,
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/add_building')},
                    child: new Container(
                        child: new Text(
                      'اذا كنت ترغب باضافة عقارك اضغط هنا',
                      style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 17,
                          color: Colors.white),
                    )),
                    minWidth: MediaQuery.of(context).size.width,
                  ),)),
     
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        new Container(
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.all(10),
                                  child: new Row(
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      new Text(
                                        'تطبيق',
                                        style: TextStyle(
                                            fontFamily: 'DroidSansArabic',
                                            fontSize: 25,
                                            color: Colors.grey),
                                      ),
                                      new Text(
                                        'ركن ',
                                        style: TextStyle(
                                            fontFamily: 'DroidSansArabic',
                                            fontSize: 25,
                                            color: Themes.Colors.bulecolors),
                                      ),
                                      new Text(
                                        'المكان ',
                                        style: TextStyle(
                                            fontFamily: 'DroidSansArabic',
                                            fontSize: 25,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: new Row(
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      new Text(
                                        'الامثل',
                                        style: TextStyle(
                                            fontFamily: 'DroidSansArabic',
                                            fontSize: 25,
                                            color: Colors.grey),
                                      ),
                                      new Text(
                                        'لاستثمارك ',
                                        style: TextStyle(
                                            fontFamily: 'DroidSansArabic',
                                            fontSize: 25,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                new InkWell(
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            new see_all_building(
                                                advertisss),
                                          ))
                                    },
                                    child: new Text(
                                      'مشاهده جميع الاعلانات',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontFamily: 'DroidSansArabic'),
                                    )),
                                futurbuilder,
                                new SizedBox(
                                  height: 5,
                                ),
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 130,
                                  child: futurbuilder_catergory,
                                )

                                ///////////////////////////////////////////
                              ],
                            )),
                      ],
                    )
                )
            ),
          ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        appBar: new AppBar(
          title: title(),
          bottomOpacity: 1.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Themes.Colors.bulecolors),
          backgroundColor: Colors.white10,
        ),
        /////////////////////////////////////////////////////////////////////////////
        drawer: new Drawer(child: new Drawerpage(),),
         
        
         
        );
  }
}

class advertis {
  final int id;
  final String name;
  final String image;

  final String link;

  final String created_at;
  final String updated_at;
  advertis(this.id, this.name, this.image, this.link, this.created_at,
      this.updated_at);
}

class catogray {
  final int id;
  final String arabic_name;
  final String english_name;

  final String image;
  final String notes;

  final String created_at;
  final String updated_at;
  final String logo;
  catogray(this.id, this.arabic_name, this.english_name, this.image, this.notes,
      this.created_at, this.updated_at, this.logo);
}
