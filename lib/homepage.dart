import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:form_field_validator/form_field_validator.dart';
import 'loginpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //this is use for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User detail"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
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
                      TextFormField(
                        controller: namecontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: " Full Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        keyboardType: TextInputType.visiblePassword,
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
                            registerNow();
                          },
                          icon: Icon(Icons.forward),
                          label: Text("Register"))
                    ],
                  )))),
    );
  }

  Future<void> registerNow() async {
    var baseurl = "http://raushanjha.in/demoapi/register.php";
    var params = {
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
      "name": namecontroller.text
    };
    try {
      var url = Uri.parse("$baseurl");
      var response = await http.post(url, body: params);
      if (emailcontroller.text.isNotEmpty &&
          passwordcontroller.text.isNotEmpty &&
          namecontroller.text.isNotEmpty) {
        print(response.body);
        print(response.body.runtimeType);
        var jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registerd")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Try Again")));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
