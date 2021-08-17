import 'package:flutter/material.dart';
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/drawer.dart';

class about_app extends StatefulWidget {
  @override
  _about_appState createState() => _about_appState();
}


class textfiled extends StatelessWidget {
  final String hint;
  final String asd;

 final TextEditingController tc;
 
  const textfiled({
    this.asd,
     this.tc,
    this.hint,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      height: 50.0,
      width:MediaQuery.of(context).size.width-20 ,
      decoration: new BoxDecoration(
          
          color: Colors.cyan,
          border: new Border.all(color: Colors.black, width: 1.0),
          borderRadius: new BorderRadius.circular(15.0)),
           child: new TextFormField(
             controller: tc,
             textDirection: TextDirection.rtl, 
             textAlign:TextAlign.center ,
             
             
        decoration: InputDecoration.collapsed(hintText: hint,hintStyle: TextStyle(fontSize: 20,fontFamily: 'DroidSansArabic',color: Colors.white)),
      ),
    );
  }
}

class _about_appState extends State<about_app> {

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
     
        body: Container(
          padding: EdgeInsets.all(20),
                  child: new Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
           new Text('تطبيق ركن هو اول تطبيق في العراق يختص بعرض العقارات بانواعها المختلفة, يتميز التطبيق بسهولة الاستخدام لرفع وعرض تفاصيل العقارات والاستفسار عنها مجانا ويمكنك تحميل التطبيق على الهواتف الذكية من الابل ستور وكوكل بلي او زيارة الموقع الالكتروني الخاص بالمشروع', textAlign: TextAlign.end,style:TextStyle(color:Colors.black,fontSize: 17,fontFamily: 'DroidSansArabic')),


                ],
              
            ),
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        appBar: new AppBar(
          title: new Text('  عن التطبيق'),
          centerTitle: true,
        ));
        /////////////////////////////////////////////////////////////////////////////
        
  }
}