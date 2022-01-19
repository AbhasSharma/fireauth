

import 'package:flutter/material.dart';

import 'main.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Userpage extends StatefulWidget {
  const Userpage({ Key? key }) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}


class _UserpageState extends State<Userpage> {
  

   Future<void> getUsers() async {
    var baseurl = "http://raushanjha.in/demoapi/alluser.php";

    var url = Uri.parse("$baseurl");
    var response = await http.get(url);
    print(response.body);
    print(response.body.runtimeType);
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User data"),),
      
    );
  }
}
/* void validate() {
    if (_formKey.currentState!.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }
   validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please enter valid email");
                          }
                           return '';
                        },
                        onSaved: (String? email) {},*/