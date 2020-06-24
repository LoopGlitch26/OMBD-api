import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: IMBD(),
    );
  }
}

class IMBD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IMBDState();
      }
    }


class IMBDState extends State<IMBD> {
 
  final String url = "";
  TextEditingController movieController =
      TextEditingController(text: " ");
  var res;
  var conv;
  //movie variables
  String title = " ";
  String year = " ";
  String poster =
      " ";
  String runtime = " ";
  String director = " ";

  String imdbRating = " ";
  String boxoffice = " ";
  String country = " ";
  String actors =
      " ";
  String plot = " ";


  Future<String> getJsonData() async {
    res = await http.get(
        Uri.encodeFull(
            "http://omdbapi.com/?apikey=7c01d414+&t=${movieController.text}"),
        headers: {"Accept": "application/json"});

    setState(() {
      conv = json.decode(res.body);
      title = conv['Title'];
      year = conv['Released'];
      poster = conv['Poster'];
      runtime = conv['Runtime'];
      director = conv['Director'];

      imdbRating = conv['IMBD-Rating'];
      boxoffice = conv['BoxOffice'];
      country = conv['Country'];
      actors = conv['Actors'];
      plot= conv['Plot'];

      print(conv['Title']);
    });
    return "Sucess";
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Movie")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Movie Name'),
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      controller: movieController,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    RaisedButton(
                      elevation: 5,
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: 20, ),
                      ),
                      onPressed: () =>
                          movieController.text !=null ? getJsonData() : "",
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 500,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network("$poster", height: 450, width: 450),
                              Padding(padding: EdgeInsets.only(top: 15)),
                              Text(
                                "Title :$title",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Release Year : $year",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Runtime : $runtime",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Director : $director",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Boxoffice : $boxoffice",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Country : $country",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Actors : $actors",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                "Plot : $plot",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 15  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
