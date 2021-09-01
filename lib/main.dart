import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_practice/network_calls/base_manager.dart';
import 'package:youtube_practice/network_calls/base_networks.dart';
import 'package:youtube_practice/network_calls/base_response.dart';
import 'package:youtube_practice/screens/home_page.dart';
import 'package:youtube_practice/screens/registrationPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController() ;
  final passwordController = TextEditingController();
  bool _loading = false;
  Future<void> performLogin() async {
    String name = nameController.text.trim();
    String pass = passwordController.text.trim();
    if (name.isEmpty || pass.isEmpty) {
      Fluttertoast.showToast( msg:"enter details");
      return;
    }

    setState(() {
      _loading = true;
    });

    final response = await authManager.performLogin(name , pass);

    setState(() {
      _loading = false;
    });

    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg:response.message);
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
      // NavigationService().navigatePage(HomePage());
    } else {
      Fluttertoast.showToast(msg:response.message);
    }
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:AppColor.backgroungcolor,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 150,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                     // borderRadius:AppColor.borderradius,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2 ),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,size: 20,),
                        hintText: "username",
                       // hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      // borderRadius:AppColor.borderradius,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2 ),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,size: 20,),
                        hintText: "password",
                        // hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100,),
                Container(
                  width: 140,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    onPressed: (){
                      performLogin();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(),
                          width: 130,
                          child: Text("login",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20,),),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    // child: Container(
                    //   height: 2,
                    //   width: 90,
                    //   child: a.GradientLinearProgressIndicator(
                    //     valueGradient: g1,
                    //     backgroundColor: Colors.purple[300],
                    //   ),
                    // ),
                    child: Container(
                      height: 3,
                      width: 50,
                      decoration: BoxDecoration(
                        gradient:LinearGradient(
                            colors: [
                              Color(0xFFFF8D1B),
                              Color(0xFFFF0000),
                              Color(0xFFE41698),
                              Color(0xFF0038D1),
                              //add more colors for gradient
                            ],
                            begin: Alignment.topLeft, //begin of the gradient color
                            end: Alignment.bottomRight, //end of the gradient color
                            stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                          //set the stops number equal to numbers of color
                        ),
                      ),
                    )
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegistrationPage()));
                  },
                    child: Text("for registration click here"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

