import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blueGrey,
    primaryColorDark: Colors.blueGrey,
    primarySwatch: Colors.blueGrey
  ),
  home: new HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List data;

  Future<String> getData() async{
    
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers:{
          "Accept":"application/json"
        }
    );

    this.setState((){

      data = jsonDecode(response.body);

    });

    data = jsonDecode(response.body);
    //print(data);
   // print(data[1]['userId']);
    print(data[1]['title']);
   // print(data[1]['body']);

    return "success!";
    
  }
  
  @override
  void initState(){
    this.getData();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("ListViewData"),
      ),
      /*body:Center(
        child: RaisedButton(
            child: new Text("clickme"),
            onPressed: getData),
      ) ,
      */


      body: new ListView.separated(

        itemCount: data == null ? 0 :data.length,
        separatorBuilder: (context,index)=> Divider(),
        itemBuilder: (BuildContext context, int index){

          return ListTile(
            isThreeLine: false,
            leading:CircleAvatar(
              child: new Icon(Icons.book,color: Colors.greenAccent,),//showing front of the line,
            ) ,
            trailing: new Icon(Icons.trending_down,color: Colors.green,),//showing end of the line
            title: new Text('User ID :'+data[index]['id'].toString()),
            subtitle: new Text('Title :'+data[index]['title'],maxLines: 2,overflow: TextOverflow.ellipsis,),
          );

/*
            new Card(
            child: new Text(data[index]['title']),color: Colors.grey,
          );
*/
        },

      ),
    );
  }
}
