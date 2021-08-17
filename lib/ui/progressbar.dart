import 'package:flutter/material.dart';

class progressbar extends StatefulWidget {
  @override
  _progressbarState createState() => _progressbarState();
}

class _progressbarState extends State<progressbar> {
   
  @override
  Widget build(BuildContext context) {
    return new Container(
                    decoration: new BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: new BorderRadius.circular(10.0)
                    ),
                    width: 100.0,
                    height: 100.0,
                    alignment: AlignmentDirectional.center,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Center(
                          child: new SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: new CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          child: new Center(
                            child: new Text(
                              'loading.. wait...',
                              style: new TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    );
  }
}