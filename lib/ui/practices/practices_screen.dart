import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/practices/posttest/posttest_screen.dart';
import 'package:gamapath/ui/practices/pretest/pretest_screen.dart';

class PracticesScreen extends StatefulWidget{
  final String practicesName;
  final String practicesId;

  const PracticesScreen({Key? key, required this.practicesId, required this.practicesName}): super(key: key);

  @override
  _PracticesScreenState createState() => _PracticesScreenState();
}

class _PracticesScreenState extends State<PracticesScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(widget.practicesName),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              child:  Container(
                width: double.infinity,
                child: Card(
                  child: Container(
                    margin:  EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text("Pre-Test")
                      ],
                    ),
                  ),
                ),
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>PretestScreen(
                          praticesId: '22',
                        )
                    )
                );
              }
            ),
            GestureDetector(
                child:  Container(
                  width: double.infinity,
                  child: Card(
                    child: Container(
                      margin:  EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text("Post-Test")
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>PosttestScreen(
                            praticesId: '22',
                          )
                      )
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}