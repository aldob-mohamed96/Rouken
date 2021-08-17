import 'package:flutter/material.dart';

import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/login_and_register.dart';
import 'package:cached_network_image/cached_network_image.dart';

class actionsappbar extends StatefulWidget {
 
  @override
  _actionsappbarState createState() => _actionsappbarState();
}
 
class _actionsappbarState extends State<actionsappbar> {
  

  
  @override
  Widget build(BuildContext context) {
  
  return new Image.asset('assets/img/logo.png');
  }
}
class drawerimages extends StatefulWidget {
   
  @override
  _drawerimagesState createState() => _drawerimagesState();
}

class _drawerimagesState extends State<drawerimages> {
  
  @override
  Widget build(BuildContext context) {

    return new CircleAvatar(
      backgroundColor: Themes.Colors.bulecolors,
      backgroundImage:userforall==null? null:new NetworkImage(userforall.avatar.toString())

      ,
      radius: 50,
    );
  }
}

class drawerimage extends StatefulWidget {
 
  @override
  _drawerimageState createState() => _drawerimageState();
}

class _drawerimageState extends State<drawerimage> {

  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(top: 50),
        ),
        userforall==null?  Text(''):new Text(
       userforall.name.toString().length>15?userforall.name.substring(0,15):userforall.name,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white),
        ),
        new SizedBox(
          height: 1.0,
        ),
       
       /////////////////////////////////////////////////////////
      ],
    );
  }
}

class title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color: Themes.Colors.bulecolors,
          ),
          color: Themes.Colors.bulecolors,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       Image.asset('assets/img/logo.png',height: 200,fit: BoxFit.cover,)
       
        
      ],
    );
  }
}

class title2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       Image.asset('assets/img/logo.png',height: 100,fit: BoxFit.cover,color:Colors.white,)
       
        
      ],
    );
  }
}
class title3 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       new Text('عقارات للاستثمار',style: TextStyle( fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic'))
     ,  new Padding(padding: EdgeInsets.all(0),)
        
      ],
    );
  }
}
class title4 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       new Text('سكن مشترك',style: TextStyle( fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic'))
     ,  new Padding(padding: EdgeInsets.all(0),)
        
      ],
    );
  }
  // 'عقارات للايجار'
}
class title5 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       new Text('عقارات للايجار',style: TextStyle( fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic'))
     ,  new Padding(padding: EdgeInsets.all(0),)
        
      ],
    );
  }
  //'عقارات للبيع' 
}
class title6 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       new Text('عقارات للبيع',style: TextStyle( fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic'))
     ,  new Padding(padding: EdgeInsets.all(0),)
        
      ],
    );
  }
  //
}
class title7 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        
       new Text('تغيير كلمه السر',style: TextStyle( fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic'))
     ,  new Padding(padding: EdgeInsets.all(0),)
        
      ],
    );
  }
  //
}

class TitleSub extends StatelessWidget {
 final String title;
  const TitleSub({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new IconButton(
          icon: Icon(
            Icons.search,
            color:Colors.white,
          ),
          color: Colors.white,
          splashColor: Themes.Colors.bulecolors,
          onPressed: (){
            Navigator.of(context).pushNamed('/search');
          },
        ),
        Spacer(flex: 10,),
        new Text(title,style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic'))
      ],
    );
  }
  //'عقارات للبيع' 
}