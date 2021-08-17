import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/building_to_selling.dart'; 
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
 
import 'package:flutter_apps/utils/user.dart';
import 'dart:convert';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> with SingleTickerProviderStateMixin {
  
  String time = 'اقل من ساعه';
  List<building> buildingList=[];
  
  Future<List<building>> _getInformation() async {
    
    final response = await http.get('https://rouckn.com/api/v1/user/posts/',
    headers:{
        'Content-Type':'application/x-www-form-urlencoded',
        'Auth':userforall.token.toString(),
      },
    );

    var dataUser = json.decode(response.body);
  
    for(var u in dataUser['posts']) {
      List<String> files=[];
      
      for(var u in u['files'])
      {
        files.add(u.toString());
      }
   
     int year = int.parse(u['created_at'].toString().substring(0,4));
     int currentYear = int.parse(DateTime.now().year.toString());
     int month = int.parse(u['created_at'].toString().substring(5,7));
     int currentMonth = int.parse(DateTime.now().month.toString());
     int day = int.parse(u['created_at'].toString().substring(8,10));
     int currentDay = int.parse(DateTime.now().day.toString());
     int hour = int.parse(u['created_at'].toString().substring(11,13));
     int currentHour = int.parse(DateTime.now().hour.toString());
     
     if(year == currentYear) {
       if(month == currentMonth) {
         if(day == currentDay) {
           if(hour == currentHour) {
              setState(() {
               time = 'منذ ساعة'; 
              });
           } else {
             setState(() {
               time =' من '+(currentHour-hour<0?(-1*(currentHour-hour)):(currentHour-hour)).toString()+' ساعه ';
           
             });
           }
         } else {
           setState(() {
             time=' من '+(currentDay-day).toString()+' يوم ';
           });
         }
       } else {
           setState(() {
             time=' من '+(currentMonth-month).toString()+' شهر '; 
           });
         }
       } else {
         setState(() {
           time=' من '+(currentYear-year).toString()+' سنه '; 
         });
      }
     
      building b1=new building(
        u['id'].toString(), 
        u['title'].toString(),
        u['category_id'].toString(), 
        u['subcategory_id'].toString(),
        u['user_id'].toString(),
        u['approved'].toString(), 
        u['hash'].toString(), 
        u['price'].toString(),
        u['country'].toString(),
        u['governorate'].toString(),
        u['region'].toString(),
        u['address'].toString(),
        u['area'].toString(), 
        u['has_parking'].toString(),
        u['rooms_number'].toString(),
        u['floors_number'].toString(), 
        u['construction_year'].toString(),
        u['lat_lng'].toString(), 
        u['notes'].toString(),
        u['extra'].toString(), 
        time,
        u['updated_at'].toString(),
        u['image'].toString(),
        files,
        u['phone'].toString(),
        'me',
        'me' ,
        u['favorite']
      );
      
      buildingList.add(b1);
    }
  
    return buildingList;
  }


   void initState() { 
      super.initState();
     _getInformation();
     
     setState(() {
      buildingList = [];
     });
   }

  Widget _buildItem(int index) {
    return new Container(
      width: 340,
      
      // color: Colors.blue,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/display_item');
           setState(() {
           show_details=buildingList[index]; 
          });
        },
        child: new Card(
          child: new Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             new Container(
               width: 340,
               decoration: BoxDecoration(
                   border: new Border.all(width: 1.0),
                   borderRadius: new BorderRadius.circular(4.0)
               ),
               child: new CachedNetworkImage(
                    alignment: Alignment.center,fit: BoxFit.fill,
                    height: 280,
                    repeat: ImageRepeat.noRepeat,
                    imageUrl: buildingList[index].image,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        new Icon(Icons.question_answer),
                  ),
             ),
             new SizedBox(height: 16,),
                new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Padding(padding: EdgeInsets.only(left: 5)),
                   new Directionality(
                     textDirection: TextDirection.rtl,
                     child: new Text(buildingList[index].created_at, 
                         style: TextStyle(
                            fontFamily: 'DroidSansArabic',
                            fontSize: 14,
                            color: Colors.grey)
                     ),
                   ),
                   Spacer(flex: 10,),
                   Container(
                     padding: EdgeInsets.all(10.0),
                     child: new Text(userforall.name.toString()),
                   ),
                   Container(
                     padding: EdgeInsets.only(left: 10.0),
                     child: new CircleAvatar(backgroundImage: NetworkImage(userforall.avatar.toString()),),
                   ),
                   Padding(padding: EdgeInsets.only(left: 2,right: 2,),),
                ],),
             new Container(
               alignment: Alignment.centerRight,
               padding: EdgeInsets.all(10),
               child: 
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: new Text(buildingList[index].title.toString(),
                    style: TextStyle(
                        fontFamily: 'DroidSansArabic',
                        fontSize: 14,
                        color: Colors.grey,
                    ),
                  ),
               ),
             )
            ],
          )
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new BottomAppBar(
          clipBehavior: Clip.hardEdge,
          elevation: .1,
          notchMargin:7.0,
          color: Colors.blueAccent, 
          child: new Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: new MaterialButton(
                height: 65,
                color: Themes.Colors.bulecolors,
                textColor: Colors.white,
                onPressed: () => {Navigator.of(context).pushNamed('/add_building')},
                child: new Container(
                    child: new Text(
                  'أذا كنت ترغب بأضافة عقار اضغط هنا',
                  style: TextStyle(
                      fontFamily: 'DroidSansArabic',
                      fontSize: 15,
                      color: Colors.white),
                )),
                minWidth: MediaQuery.of(context).size.width,
              ),
           )
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
          },
          child: new Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              SingleChildScrollView(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height >= 600.0
                          ? MediaQuery.of(context).size.height
                          : 600.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: new ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: buildingList.length,
                              // itemExtent: 10.0,
                              // reverse: true, //makes the list appear in descending order
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return _buildItem(index);
                              }
                            ),
                          ),
                        ],
                      ))),

            ],
          )
      ),
  ///////////////////////////////////////////////////////////////////////////////////////////

   appBar: new AppBar(
      title: new Text('منشوراتي'),
      centerTitle: true,
    ));
  }
}
