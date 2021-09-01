import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_practice/models/add_category.dart';
import 'package:youtube_practice/models/categoriesmodel.dart';

import 'package:youtube_practice/models/category_model.dart';
import 'package:youtube_practice/models/newsfeed_model.dart';
import 'package:youtube_practice/network_calls/base_networks.dart';
import 'package:youtube_practice/screens/videospage.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _fetching = true;
  late int categoryindx;

  CategoryAddModel? addcategories;
  List<NewsfeedModel>? news;
  CategoriesModel? allcategories;
  dynamic res ;

  void fetch_categories() async {
    setState(() {
      _fetching = true;
    });
    try {

      Response response = await dioClient.ref.get("/categories/",

      );
      setState(() {
        allcategories = categoriesModelFromJson(jsonEncode(response.data));
        _fetching = false;
        //print(categories!.totalCount);
        // print("token here is ${access}");

      });
      print(response);
    } catch (e) {
      setState(() {
        _fetching = false;
      });
      print(e);
    }
  }

  // void fetch_genres() async {
  //   setState(() {
  //     _fetching = true;
  //   });
  //   try {
  //
  //     Response response = await dioClient.ref.get("/category/?category_id=1",
  //
  //     );
  //     setState(() {
  //       categories = categoryModelFromJson(jsonEncode(response.data));
  //       _fetching = false;
  //       //print(categories!.totalCount);
  //      // print("token here is ${access}");
  //
  //     });
  //     print(response);
  //   } catch (e) {
  //     setState(() {
  //       _fetching = false;
  //     });
  //     print(e);
  //   }
  // }
  final nameController = TextEditingController();
  void addcategory()async{
    String text = nameController.text.trim();
    FormData data = FormData.fromMap({
      "name":text,
    });
    Response response = await dioClient.ref.post("/category/",data: data

    );
    setState(() {
      addcategories = categoryAddModelFromJson(jsonEncode(response.data));

      print(response.data);
      res=response.statusMessage;
      print(response);
    });
  }
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Enter name"
                        ),
                      ),
                    ),

                    RaisedButton(
                        child: Text("Submit"),
                        onPressed: (){
                          addcategory();
                          setState(() {

                          });
                        }),
                   // res == null ? Text("")  : Text("test --- ${res}"),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    //fetch_genres();
    fetch_categories();
    addcategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Categories",style: TextStyle(color: Colors.amber,fontSize: 18,fontWeight: FontWeight.w600),)),
                  Spacer(),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
                          _displayDialog(context);
                        },
                          child: Icon(Icons.add)),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
                        },
                          child: Icon(Icons.edit)),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
                        },
                          child: Icon(Icons.delete))
                    ],
                  )
                ],
              ),
              userdata(),
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Channels",style: TextStyle(color: Colors.amber,fontSize: 18,fontWeight: FontWeight.w600),)),

              // Container(
              //   width: 140,
              //   child: FlatButton(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              //     onPressed: (){
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 28.0),
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           decoration: BoxDecoration(),
              //           width: 130,
              //           child: Text("more categories",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20,),),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
  Widget userdata (){
    if(_fetching){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // return Center(child: Text(categories?.categoryName));
    return   SizedBox(
      height: 50,
      child: ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        itemCount: allcategories!.videos.length,
        //itemCount: news!.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){

         // setState(() {
         //   categoryindx=allcategories!.videos[index].categoryId;
         //   Video indx=allcategories!.videos[index];
         // });
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      categoryindx=categoryindx;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.pink
                    ),
                      child: Text(allcategories!.videos[index].name)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
