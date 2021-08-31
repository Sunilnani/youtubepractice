import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_practice/network_calls/base_manager.dart';
import 'package:youtube_practice/network_calls/base_response.dart';
import 'package:youtube_practice/screens/home_page.dart';
class RegistrationPage extends StatefulWidget {


  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController() ;
  final passwordController = TextEditingController();
  final confpasswordController = TextEditingController();
  bool _loading = false;
  Future<void> preformRegister() async {
    String name = nameController.text.trim();
    String pass = passwordController.text.trim();
    String confpass=confpasswordController.text.trim();
    if (name.isEmpty || pass.isEmpty) {
      Fluttertoast.showToast( msg:"enter details");
      return;
    }

    setState(() {
      _loading = true;
    });

    final response = await authManager.preformRegister(name , pass, confpass);

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
                      controller: confpasswordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,size: 20,),
                        hintText: "repassword",
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

                      preformRegister();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
