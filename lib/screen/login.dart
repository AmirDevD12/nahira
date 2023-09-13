import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'home.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String pass = '';
  String name = '';
  String informationfilm="";
  List<String> nameganers=[];
  @override
  void initState() {
    // TODO: implement initState
    information();
    ganer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(240))
                ),
                child: const Icon(Icons.person,size: 140,color: Colors.white,),
              ),
              const SizedBox(
                height: 20,
              ),
             const SizedBox(
                height: 30,
              ),
              getTextField("name", (t) {
                name = t;
              }),
              const SizedBox(
                height: 10,
              ),

              getTextField("Email", (t) {
                email = t;
              }),
              const SizedBox(
                height: 10,
              ),
              getTextField("Password", (t) {
                pass = t;
              }),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: (){
                  if (name!=""&&email!=""&&pass!="") {
                    login();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700
                ),
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12, right: 12, left: 12),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Sign in",
                style: TextStyle(color: Colors.black38,fontSize: 20),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTextField(
      String text,
      ValueChanged<String>? a,
      ) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onChanged: a,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        labelStyle: const TextStyle(color: Colors.white38),
      ),
    );
  }
  Future<void> login() async {

    Map <String,dynamic> namejson={'name':name};
    Map <String,dynamic> emailjson={'name':email};
    Map <String,dynamic> passjson={'name':pass};
  String jsname= jsonEncode(namejson);
  String jsemail= jsonEncode(emailjson);
  String jspass= jsonEncode(passjson);

    final dio = Dio();
    try {
      final response =
      await dio.post('https://moviesapi.ir/api/v1/register', data: {
        'email': jsemail,
        'password': jspass,
        'name': jsname,
      });
      EasyLoading.show();
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(information: informationfilm,nameganers: nameganers,)));
        EasyLoading.showSuccess('login successful');

      } else {

      }
    } catch (t) {
      EasyLoading.showError(" failed");
    }
  }
  Future<void> information() async {
    final dio = Dio();
    try {
      final response =
      await dio.get('https://moviesapi.ir/api/v1/movies?page=1', data: {});
      if (response.statusCode == 200) {
        informationfilm = jsonEncode(response.data);
      } else {

      }
    } catch (t) {
      EasyLoading.showError(" failed");
      print(t);
    }
  }

  Future<void> ganer() async {
    final dio = Dio();
    try {
      final response =
      await dio.get('https://moviesapi.ir/api/v1/genres', data: {});
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data != null) {
          for (int i = 0; i < 10; i++) {
            nameganers.add(response.data[i]["name"].toString());
          }
        }
      } else {
      }
    } catch (t) {
      EasyLoading.showError(" failed");
      print(t);
    }
  }
}
