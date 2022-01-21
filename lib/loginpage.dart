import 'package:flutter/material.dart';
import 'userspage.dart';
import 'main.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
 // var namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User detail"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: ClipOval(
              child: Image.network(
                "https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-1.jpg",
                height: 100,
                width: 100,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailcontroller,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordcontroller,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.remove_red_eye),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          OutlinedButton.icon(
              onPressed: () {
                loginnow();
              },
              icon: Icon(Icons.login),
              label: Text("Login"))
        ],
      ))),
    );
  }

  Future<void>loginnow() async {
    var baseurl =  "http://raushanjha.in/demoapi/login.php";
    var params = {
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
     
    };
    try {
      var url = Uri.parse("$baseurl");
      var response = await http.post(url, body: params);
      if (emailcontroller.text.isNotEmpty &&
          passwordcontroller.text.isNotEmpty )
          {
        print(response.body);
        print(response.body.runtimeType);
        var jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Logging in...")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Userpage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Try Again")));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}