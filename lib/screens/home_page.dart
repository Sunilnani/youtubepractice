import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  CategoryModel? categories;
  List<NewsfeedModel>? news;


  void fetch_genres() async {
    setState(() {
      _fetching = true;
    });
    try {

      Response response = await dioClient.ref.get("/category/?category_id=1",

      );
      setState(() {
        categories = categoryModelFromJson(jsonEncode(response.data));
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


  @override
  void initState() {
    fetch_genres();
    //fetch_newsfeed();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            userdata(),
            SizedBox(height: 200,),
            Container(
              width: 140,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
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

          ],
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
    return   ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories!.categoryName.length,
      //itemCount: news!.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){
       // return Text(categories!.videos[index].name);
        return Text(categories!.categoryName);
     },
    );
  }
}
