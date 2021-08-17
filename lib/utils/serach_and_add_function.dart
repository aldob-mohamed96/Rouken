import 'package:flutter/material.dart';

class drobdown3 extends StatefulWidget {
  String hint;
  List _lists;
  String select;

  drobdown3(String hint, List _list, String select) {
    this.hint = hint;
    this._lists = _list;
    this.select = select;
  }

  @override
  _drobdown3State createState() => _drobdown3State(hint, _lists, select);
}

class _drobdown3State extends State<drobdown3> {
  String hint;
  List _list;
  String select;

  _drobdown3State(String hint, List _list, String select) {
    this.hint = hint;
    this._list = _list;
    this.select = select;
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        height: 50.0,
        width: MediaQuery.of(context).size.width - 20,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.white, width: 1.0),
            borderRadius: new BorderRadius.circular(15.0)),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
                child: new DropdownButtonHideUnderline(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: new DropdownButton<String>(
                  items: _list.map((value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      select = v;
                      widget.hint = v;
                    });
                  },
                ),
              ),
            )),
            new Container(
              child: new Text(widget.hint,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'DroidSansArabic')),
            )
          ],
        ));
  }
}

class drobdown2 extends StatefulWidget {
  String hint;
  String select;
  List _lists;

  drobdown2(String hint, List _list, String select) {
    this.hint = hint;
    this._lists = _list;
    this.select = select;
  }

  @override
  _drobdown2State createState() => _drobdown2State(hint, _lists, select);
}

class _drobdown2State extends State<drobdown2> {
  String hint;
  List _list;
  String select;

  _drobdown2State(String hint, List _list, String select) {
    this.hint = hint;
    this._list = _list;
    this.select = select;
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(1.0),
        alignment: Alignment.center,
        height: 50.0,
        width: MediaQuery.of(context).size.width / 2 - 20,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.white, width: 1.0),
            borderRadius: new BorderRadius.circular(15.0)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    items: _list.map((value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        select = v;
                        widget.hint = v;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
                child: new Text(widget.hint,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'DroidSansArabic'))),
          ],
        ));
  }
}
