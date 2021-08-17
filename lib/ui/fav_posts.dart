import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/building_to_selling.dart'; 
import 'package:flutter_apps/ui/login_and_register.dart'; 
import 'package:http/http.dart' as http;
import 'package:flutter_apps/utils/user.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:toast/toast.dart';

class fav_posts extends StatefulWidget {
  @override
  _fav_postsState createState() => _fav_postsState();
}
int post_id_fav;
class _fav_postsState extends State<fav_posts>
    with SingleTickerProviderStateMixin {
  List<bool> icon_fav_colors = [];
   
  String time='اقل من ساعه';
     List<building> buildinglist=[];
     
//////////////////////////////////////////////////////////////////


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
///////////////////////////////////////////////////////////////////
     


    Future<List<building>> _getinfromation() async {
  

  final response = await http.get('https://rouckn.com/api/v1/user/favourites',
  headers: {'Content-Type':'application/x-www-form-urlencoded',
  'Auth':userforall.token.toString(),
  
  },);


  var datauser = json.decode(response.body);
   
  
  for(var u in datauser['favourites'])
    {
         if(u['post']==null)
         continue;
      List<String> files=[];
      for(var u in u['post']['files'])
      {
        files.add(u.toString());
      }
   
     int year=int.parse(u['post']['created_at'].toString().substring(0,4));
     int yearcurrnet=int.parse(DateTime.now().year.toString());
     int mounth=int.parse(u['post']['created_at'].toString().substring(5,7));
     int mounthcurrent=int.parse(DateTime.now().month.toString());
     int day=int.parse(u['post']['created_at'].toString().substring(8,10));
     int daycurrnet=int.parse(DateTime.now().day.toString());
     int hour=int.parse(u['post']['created_at'].toString().substring(11,13));
      int hourcurrent=int.parse(DateTime.now().hour.toString());
     if(year==yearcurrnet)
     {
       if(mounth==mounthcurrent)
       {
         if(day==daycurrnet)
         {
           if(hour==hourcurrent)
           {
              setState(() {
               time; 
              });
              
           }
           else
           {
               setState(() {
             time=' من '+(hourcurrent-hour<0?(-1*(hourcurrent-hour)):(hourcurrent-hour)).toString()+' ساعه ';
         
           });
         
           }


         }
         else
         {
         setState(() {
           time=' من '+(daycurrnet-day).toString()+' يوم ';
           
         });
         }
         

       }
       else
       {
         setState(() {
           time=' من '+(mounthcurrent-mounth).toString()+' شهر '; 
         });
         

       }
     }
     else
     {

       setState(() {
         time=' من '+(yearcurrnet-year).toString()+' سنه '; 
       });
  
  
     }
    

     
      building b1=new building(
      u['post']['id'].toString(), 
      u['post']['title'].toString(),
      u['post']['category_id'].toString(), 
      u['post']['subcategory_id'].toString(),
      u['post']['user_id'].toString(),
      u['post']['approved'].toString(), 
      u['post']['hash'].toString(), 
      u['post']['price'].toString(),
      u['post']['country'].toString(),
      u['post']['governorate'].toString(),
      u['post']['region'].toString(),
      u['post']['address'].toString(),
      u['post']['area'].toString(), 
      u['post']['has_parking'].toString(),
      u['post']['rooms_number'].toString(),
      u['post']['floors_number'].toString(), 
      u['post']['construction_year'].toString(),
      u['post']['lat_lng'].toString(), 
      u['post']['notes'].toString(),
      u['post']['extra'].toString(), 
      time,
      u['post']['updated_at'].toString(),
      u['post']['image'].toString(),

      files, 
      u['post']['phone'].toString(),
      u['post']['user']['image'].toString()
      ,
      u['post']['user']['name'].toString(),
      u['favorite']
      );

  
  buildinglist.add(b1);



    }
   
    return buildinglist;
    
  
}


 void initState() { 
    super.initState();
   _getinfromation();
   setState(() {
    buildinglist;
    
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
           show_details=buildinglist[index]; 
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
                height: 300,
                alignment: Alignment.center,
                fit: BoxFit.fill,
                repeat: ImageRepeat.noRepeat,
                imageUrl: buildinglist[index].image,
                placeholder: (context, url) => new Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
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
                 child:  new Text(buildinglist[index].created_at,style: TextStyle(

                            fontFamily: 'DroidSansArabic',
                            fontSize: 14,
                            color: Colors.grey)),
               ),

                new Padding(padding: EdgeInsets.only(left: 5,right: 120),),
                new Text(buildinglist[index].name.toString()
                  
                )
                ,
               
                 new CircleAvatar(backgroundImage:NetworkImage(buildinglist[index].avatar.toString()),),
                 Padding(padding: EdgeInsets.only(left: 2,right: 2,),),
              ],)
              ,
            Padding(
              padding: EdgeInsets.only(left: 15,right: 10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                
              new Align(
                alignment: Alignment.bottomLeft,
                child:  IconButton(icon: Icon(Icons.favorite),iconSize: 30,color: icon_fav_colors?.elementAt(index) == false ? Colors.grey : Colors.pinkAccent,
              onPressed: (){
                setState(() {
                  if(icon_fav_colors[index] == false)
                  {
                    icon_fav_colors[index] = true;
                  }
                  else
                  {
                    icon_fav_colors[index] = false;
                  }
                });

              },
              ),

        
        ),
          new Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: new Text(
                    buildinglist[index].title.toString().length>20? buildinglist[index].title.toString().substring(0,15): buildinglist[index].title.toString(),
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
                             
                               
                                  Flexible(
                            child: new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: buildinglist.length,
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
          title: new Text('المفضلات'),
          centerTitle: true,
        ));
  }
}
