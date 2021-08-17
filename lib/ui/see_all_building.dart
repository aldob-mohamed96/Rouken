import 'package:flutter/material.dart';
import 'package:flutter_apps/theme/theme.dart' as Themes;
import 'package:flutter_apps/ui/Appbar.dart';
import 'package:flutter_apps/ui/drawer.dart';
import 'package:flutter_apps/ui/home.dart';
import 'package:flutter_apps/ui/webview.dart';
import 'package:cached_network_image/cached_network_image.dart';
class see_all_building extends StatefulWidget {
 List<advertis> ad;
  see_all_building(List<advertis> asd){
    this.ad=asd;
  }
  @override
  _see_all_buildingState createState() => _see_all_buildingState();
}

class _see_all_buildingState extends State<see_all_building>
    with SingleTickerProviderStateMixin {
      
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white ,
        appBar:new AppBar(
          
          title: title2(),
          
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
        ),
        ///
        drawer: new Drawerpage(),
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
                        height: 100.0,
                        padding: EdgeInsets.all(10),
                        child: new Column(
                          
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Padding(padding: EdgeInsets.only(top:1),),
                            new Container(
                              height: 20,
                              child: new FlatButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  child: new Row(
                                    children: <Widget>[
                                      new Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                        color: Themes.Colors.bulecolors,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.all(40),
                                      ),
                                      new Text('مشاهده جميع الاعلانات',
                                          style: TextStyle(color: Colors.grey, fontSize: 20,fontStyle: FontStyle.normal,fontFamily: 'DroidSansArabic')),
                                        
                                    ],
                                    
                                  )),
                            ),
                            SizedBox(height: 20,)
                            ,
                            Flexible(
                            
                               
                                                              child: new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount:widget.ad.length,
                                    // itemExtent: 10.0,
                                    // reverse: true, //makes the list appear in descending order
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _buildItem(index);
                                    }),
                              
                            ),
                          ],
                        )))))
        ///////////////////////////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////////////
        );
  }

  Widget _buildItem(int index) {
    return new Container(
    
      padding: const EdgeInsets.all(7.0),
      child: new InkWell(
        onTap: (){
          setState(() {
           urlwebview=widget.ad[index].link;
          });
           Navigator.of(context).pushNamed('/webview');
           },
        child: new Card(
           clipBehavior: Clip.hardEdge,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
                  elevation: 1.0,
                  borderOnForeground: true,
                  margin: EdgeInsets.all(2),
                  semanticContainer: true,
          child: new CachedNetworkImage(
                      
                        imageUrl: widget.ad[index].image.toString(),
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.question_answer),
                      ),
          
          
          
        ),
      ),
    );
  }
}
