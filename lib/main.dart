import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{

  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{

    var response = await http.get(
    //To encode the url

    Uri.encodeFull(url),

    //we want only to accept json
    headers: {"Accept": "application/json"}

    );

    print(response.body);

    setState((){
      var convertDataToJson = JSON.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hello Json"),
      ),
     body: new ListView.builder(
       itemCount: data==null? 0:data.length,
       itemBuilder: (BuildContext context,int index){
           return new Container(
             child:new Center(
               child: new Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                   new Card(
                   child:new Container(
                       child: new Text(data[index]['name']),
                       padding: const EdgeInsets.all(20.0),
                       color: Colors.blueAccent,
                       
                       )
                       
                   )
                 ],
               ),
             ),
           );
       },
     ),
    );
  }
}