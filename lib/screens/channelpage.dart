import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_practice/models/channelsmodel.dart';
import 'package:youtube_practice/network_calls/base_networks.dart';
import 'package:youtube_practice/screens/home_page.dart';
class ChannelPage extends StatefulWidget {


  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  int? categoryindx=1;

   ChannelModel? channels;
  bool _fetching = true;

  XFile? image;
  // File _image;
  final ImagePicker _picker =ImagePicker();
  void filepicker()async{
    final XFile? selectimage= await _picker.pickImage(source: ImageSource.gallery);
    print(selectimage!.path);
    setState(() {
      image=selectimage;
    });
  }

  XFile? bannerimage;
  // File _image;
  final ImagePicker _pickers =ImagePicker();
  void bannerpicker()async{
    final XFile? selectimages= await _pickers.pickImage(source: ImageSource.gallery);
    print(selectimages!.path);
    setState(() {
      bannerimage=selectimages;
    });
  }
  final nameController=TextEditingController();
  final description = TextEditingController();
  final category_id=TextEditingController();
  void productsadd()async{
    String  name = nameController.text.trim();
    String descriptions = description.text.trim();


    try{
        final formData = FormData.fromMap({
        "name" : name,
        "banner":await MultipartFile.fromFile(bannerimage!.path),
        "profile_pic":await MultipartFile.fromFile(image!.path),
        "description":descriptions,
          "category_id":categoryindx
        //"image":await MultipartFile.fromFile(productimag.path)
      });
        Response response = await dioClient.ref.post("/channel/",data: formData

        );
      setState(() {
        //category = categoryFromJson(jsonEncode(response.data)) ;
        print(response.data["message"]);
        print(categoryindx);
        //responses=response.data["message"];
      });
    }
    catch(e){

    }
  }

  void fetch_channels() async {
    setState(() {
      _fetching = true;
    });
    try {

      Response response = await dioClient.ref.get("/channel/?channel_id=1",

      );
      setState(() {
        channels = channelModelFromJson(jsonEncode(response.data));
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
    fetch_channels();
    //fetch_newsfeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              child: Text("Categories",style: TextStyle(color: Color(0xFF222222),fontSize: 22,fontWeight: FontWeight.w700),),
            ),
            Container(),
            InkWell(
              onTap: (){
                _addproduct(context);
              },
              child: Container(
                height: 30,
                width: 35,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.tealAccent),
                child: Icon(Icons.add,size: 20,),
              ),
            ),
            userdata(),

            // Center(
            //   child: TextButton(
            //     onPressed: () {
            //       filepicker();
            //     },
            //     child: Text("image"),
            //   ),
            // ),
            // image==null? Text("no image"):Image.file(File(image!.path),width: 250,fit: BoxFit.cover,)
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
      itemCount: channels!.description.length,
      //itemCount: news!.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){
        // return Text(categories!.videos[index].name);
        return InkWell(
          onTap: (){
            setState(() {
              categoryindx=channels!.categoryId;
             // categoryindx=current.categoryId;
            });
          },
            child: Text(channels!.name));
      },
    );
  }
  _addproduct(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Product'),
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
                            hintText: "Enter Name"
                        ),
                      ),
                    ),
                    RaisedButton(
                        child: Text("upload"),
                        onPressed: (){
                          setState(() {
                            bannerpicker();
                          });
                        }),

                    RaisedButton(
                        child: Text("upload"),
                        onPressed: (){
                          setState(() {
                            filepicker();
                          });
                        }),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: description,
                        decoration: InputDecoration(
                            hintText: "Enter Description"
                        ),
                      ),
                    ),

                    RaisedButton(
                        child: Text("Click To Add"),
                        onPressed: (){
                          productsadd();
                          setState(() {

                          });
                        }),
                   // responses==null ?Text("enter valid details"):Text(responses),
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
                      builder: (context) => ChannelPage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }
}
