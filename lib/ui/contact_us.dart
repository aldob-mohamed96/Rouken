import 'package:flutter/material.dart';
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/drawer.dart';

class contact_us extends StatefulWidget {
  @override
  _contact_usState createState() => _contact_usState();
}


class _contact_usState extends State<contact_us> {

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
     
        body:  Padding(
          padding: EdgeInsets.all(40),
                  child: new Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              
              
                        new Text('www.rouckn.com'),
                        new Padding(padding: EdgeInsets.all(5)),
                        
                        new Text('info@rouckn.com'),
                        new Padding(padding: EdgeInsets.all(5)),
                        new Text('07718738672'),
                        new Padding(padding: EdgeInsets.all(5)),
                        

                   

                ],
              
            ),
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        appBar: new AppBar(
          title: new Text('الاتصال بنا '),
          centerTitle: true,
        ));
        /////////////////////////////////////////////////////////////////////////////
        
  }
}
