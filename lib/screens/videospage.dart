import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_practice/models/categoriesmodel.dart';
import 'package:youtube_practice/network_calls/base_networks.dart';
import 'package:youtube_practice/screens/channelpage.dart';
import 'package:youtube_practice/utils/storagekeys.dart';
class VideosPage extends StatefulWidget {

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  bool _fetching = true;

  //categoriesModel? categories;
  CategoriesModel? allcategories;
  List<Video>? videos;


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


  @override
  void initState() {
    fetch_categories();
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
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChannelPage()));
              },
                child: Text("add channels ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 20),))
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
      itemCount: allcategories!.videos.length,
      //itemCount: news!.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){
        // return Text(categories!.videos[index].name);
        return Text(allcategories!.videos[index].name);
      },
    );
  }
}
