import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
  await http.get('https://swapi.dev/api/people/4');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String name;
  final String height;
  final String mass;
  final String gender;
  final String birth_year;
  final String hair_color;
  final String eye_color;
  final String homeworld;

  Post({this.name, this.height, this.mass, this.gender, this.birth_year, this.hair_color, this.eye_color, this.homeworld});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      gender: json['gender'],
      birth_year: json['birth_year'],
      hair_color: json['hair_color'],
      eye_color: json['eye_color'],
      homeworld: json['homeworld'],

    );
  }
}


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wars API Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Star Wars API Test'),
          backgroundColor: Colors.black54,
        ),
        body: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new ExactAssetImage('assets/swlogo.png'),
                  fit: BoxFit.fitWidth
              ),
          ),
          child: Center(
            child: FutureBuilder<Post>(
              future: fetchPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    color: Colors.black54,
                    child: Container(
                      height: 300.0,
                      width: 300.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(snapshot.data.name,
                            style: new TextStyle(
                                color: Colors.yellow[900],
                                fontSize: 30.0
                            ),
                          ),
                          Container(
                            height: 50.0,
                          ),
                          Text("Height: "+snapshot.data.height,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0
                            ),
                          ),
                          Text("Mass: "+snapshot.data.mass,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0
                            ),
                          ),
                          Text("Gender: "+snapshot.data.gender,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0
                            ),
                          ),
                          Text("Birthday: "+snapshot.data.birth_year,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0
                            ),
                          ),
                          Text("Hair Color : "+snapshot.data.hair_color,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0
                            ),
                          ),
                          Text("Eye Color : "+snapshot.data.eye_color,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0
                            ),
                          ),
                          Expanded(child: Container(),),
                          Text("Homeworld : "+snapshot.data.homeworld,
                            style: new TextStyle(
                                color: Colors.white70,
                                fontSize: 12.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}",
                    style: new TextStyle(
                        color: Colors.red,
                        fontSize: 20.0
                    ),
                  );
                }

                // By default, show a loading spinner
                return CircularProgressIndicator(

                );
              },
            ),
          ),
        ),
      ),
    );
  }
}