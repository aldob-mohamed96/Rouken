import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;

import 'package:flutter_apps/ui/building_to_selling.dart';
import 'package:flutter_apps/ui/search.dart'; 
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
 
import 'package:flutter_apps/utils/user.dart';
 
import 'package:flutter_apps/ui/sub_cat.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

Future<void> _neverSatisfied(String txt, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Login Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(txt),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('login'),
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      );
    },
  );
}

class search_content extends StatefulWidget {
  @override
  _search_contentState createState() => _search_contentState();
}

class _search_contentState extends State<search_content> with SingleTickerProviderStateMixin {
  List<bool> icon_fav_colors = [];
      
 Future<void> add_fav(String post_id) async
 {
   final respone=await http.post('https://rouckn.com/api/v1/user/favourites/create',headers: {
   'Content-Type':'application/x-www-form-urlencoded',
   'Auth':userforall.token.toString()
   
   },body:{'post_id':post_id}).catchError((error){
      
       Toast.show('Post Added in your liked Posts', this.context,duration:3,backgroundColor: Colors.black,textColor: Colors.white,);
  
   });
   
    
    var jsondata = json.decode(respone.body);
    
    if(jsondata['message'].toString()=='favourite added successfully')
    {
       Toast.show('favourite added successfully', this.context,duration:3,backgroundColor: Colors.black,textColor: Colors.white,);
  
    }



 } 
 Future<void> delete_fav(String post_id) async
 {
   final respone=await http.post('https://rouckn.com/api/v1/user/favourites/delete',headers: {
   'Content-Type':'application/x-www-form-urlencoded',
   'Auth':userforall.token.toString()
   
   },body:{'post_id':post_id}).catchError((error){
      
       Toast.show('favourite post not cancled', this.context,duration:3,backgroundColor: Colors.black,textColor: Colors.white,);
  
   });
     (respone.toString());
    var jsondata = json.decode(respone.body);
    
    if(jsondata['message'].toString()=='favourite deleted successfully')
    {
       Toast.show('favourite deleted from liked group successfully', this.context,duration:3,backgroundColor: Colors.black,textColor: Colors.white,);
  
    }



 }
 
   
List<building> buildinglist_content = [];

 void initState() { 
    super.initState();
  buildinglist_content.clear();
   setState(() {
    buildinglist_content=post_search_content;
    
   });
 }
      
 
   

  Widget _buildItem(int index) {
    return post_search_content==null?new Center(child: new Text('no Reslute'),): new Container(
      width: 340,
      
      // color: Colors.blue,
      padding: const EdgeInsets.all(1.0),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/display_item');
           setState(() {
           show_details=buildinglist_content[index]; 
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
               child:  
                
                new CachedNetworkImage(
                    alignment: Alignment.center,fit: BoxFit.fill,
                    height: 280,
                  
                    repeat: ImageRepeat.noRepeat,
                    imageUrl: buildinglist_content[index].image,
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
               Padding(padding: EdgeInsets.only(left: 5,),),

               new Directionality(
                 textDirection: TextDirection.rtl,
                 child:  new Text(buildinglist_content[index].created_at,style: TextStyle(
                           
                            fontFamily: 'DroidSansArabic',
                            fontSize: 14,
                            color: Colors.grey)),
               ),

                new Padding(padding: EdgeInsets.only(left: 5,right: 120),),
                new Text(buildinglist_content[index].name.toString())
                ,
               
                 new CircleAvatar(backgroundImage:NetworkImage(buildinglist_content[index].avatar.toString()),),
                 Padding(padding: EdgeInsets.only(left: 2,right: 2,),),
              ],)
              ,Padding(
              padding: EdgeInsets.only(left: 15,right: 10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                
              new Align(
                alignment: Alignment.bottomLeft,
                child: new IconButton(
                  icon: Icon(Icons.favorite),
                  iconSize: 30,
                  color: icon_fav_colors?.elementAt(index) == false ? Colors.grey : Colors.pinkAccent,
                  onPressed: () {
                    if (userforall != null) {
                      if (icon_fav_colors[index] == false) {
                        setState(() {
                          icon_fav_colors[index] = true;
                          add_fav(buildinglist_content[index].id.toString());
                        });
                      } else {
                        setState(() {
                          icon_fav_colors[index] = false;
                          delete_fav(buildinglist_content[index].id.toString());
                        });
                      }
                    } else {
                      _neverSatisfied('login to add as liked post', context);
                    }
                 
                  },
                ),
        
        ),
          new Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: new Text(
                    buildinglist_content[index].title.toString().length>20? buildinglist_content[index].title.toString().substring(0,15): buildinglist_content[index].title.toString(),
                    style: TextStyle(
                      fontFamily: 'DroidSansArabic',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
                ],
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
                      'أذا كنت ترغب بأضافة عقار اضغط هنا',
                      style: TextStyle(
                          fontFamily: 'DroidSansArabic',
                          fontSize: 15,
                          color: Colors.white),
                    )),
                    minWidth: MediaQuery.of(context).size.width,
                  ),)),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
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
                               new SizedBox(height: 10,),
                               new Align(alignment: Alignment.topCenter,child: new Text('${post_search_content.length.toString()} نتائج البحث مشابه')),
                                new SizedBox(height: 10,),
                                  Flexible(
                            child: new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: buildinglist_content.length,
                                    // itemExtent: 10.0,
                                    // reverse: true, //makes the list appear in descending order
                                    itemBuilder: (BuildContext context, int index) {
                                      icon_fav_colors.add(false);
                                      return _buildItem(index);
                                    }),
                              
                            ),
                          ],
                        ))),
               
              ],
            )),
        ///////////////////////////////////////////////////////////////////////////////////////////
       appBar: new AppBar(
          title: new Text('${post_search_content.length.toString()} نتائج البحث '),
          centerTitle: true,
        ));
  }
}
