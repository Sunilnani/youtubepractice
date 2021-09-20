
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_practice/api_managers.dart';
import 'package:youtube_practice/models/add_category.dart';
import 'package:youtube_practice/models/categoriesmodel.dart';
import 'package:youtube_practice/models/channelsmodel.dart';
import 'package:youtube_practice/models/delete_catg_model.dart';
import 'package:youtube_practice/models/delete_channel_model.dart';
import 'package:youtube_practice/models/patch_category_model.dart';
import 'package:youtube_practice/models/patch_channel_model.dart';
import 'package:youtube_practice/network_calls/base_networks.dart';
import 'package:youtube_practice/network_calls/base_response.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _fetching = true;
  dynamic? categoryindx;
  int? channelindx;
  int? indx;

  CategoryAddModel? addcategories;
  PatchCategory? updatecategory;
  DaleteCategory? deletecatg;
  PatchChannel? patchchannels;
  DeleteChannel? deletechannels;

  CategoriesModel? allcategories;
  ChannelModel? channels;

  dynamic res ;
  dynamic patchresponse;
  dynamic respo;

  // void fetch_categories() async {
  //   setState(() {
  //     _fetching = true;
  //   });
  //   try {
  //
  //     Response response = await dioClient.ref.get("/categories/",
  //
  //     );
  //     setState(() {
  //       allcategories = categoriesModelFromJson(jsonEncode(response.data));
  //       _fetching = false;
  //       //print(categories!.totalCount);
  //       // print("token here is ${access}");
  //       print("categories index is ${categoryindx}");
  //       indx = allcategories?.videos[0].categoryId;
  //       fetch_channels();
  //     });
  //
  //
  //     print(response);
  //   } catch (e) {
  //     setState(() {
  //       _fetching = false;
  //     });
  //     print(e);
  //   }
  // }


  Future<void> fetch_categories() async {
    setState(() {
      _fetching = true;
    });

    final response = await apimanager.fetch_categories();

    setState(() {
      _fetching = false;
    });

    if (response.status == ResponseStatus.SUCCESS) {
      Fluttertoast.showToast(msg:response.message);
      setState(() {
        allcategories = response.data;
        indx = allcategories?.videos[0].categoryId;
        fetch_channels();
      });
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
      // NavigationService().navigatePage(HomePage());
    } else {
      Fluttertoast.showToast(msg:response.message);
    }
  }
  void fetch_channels() async {
    setState(() {
      _fetching = true;
    });
    try {

      Response response = await dioClient.ref.get("/category_channels/?category_id=${indx}",

      );
      setState(() {
        channels = channelModelFromJson(jsonEncode(response.data));
        _fetching = false;

      });
      print(response);
    } catch (e) {
      setState(() {
        _fetching = false;
      });
      print(e);
    }
  }

  final nameController = TextEditingController();
  final categoryIdcontoller = TextEditingController();
  final idcontroller = TextEditingController();

  // Future<void> addcategory() async {
  //   setState(() {
  //     _fetching = true;
  //   });
  //
  //   final response = await apimanager.addcategory();
  //
  //   setState(() {
  //     _fetching = false;
  //   });
  //
  //   if (response.status == ResponseStatus.SUCCESS) {
  //     Fluttertoast.showToast(msg:response.message);
  //     setState(() {
  //       allcategories = response.data;
  //       indx = allcategories?.videos[0].categoryId;
  //       fetch_channels();
  //     });
  //     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
  //     // NavigationService().navigatePage(HomePage());
  //   } else {
  //     Fluttertoast.showToast(msg:response.message);
  //   }
  // }
  void addcategory()async{
    String text = nameController.text.trim();
    FormData data = FormData.fromMap({
      "name":text,
    });
    Response response = await dioClient.ref.post("/category/",data: data

    );
    setState(() {
      addcategories = categoryAddModelFromJson(jsonEncode(response.data));
      Fluttertoast.showToast(msg:response.data['message']);

      print(response.data["message"]);
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


  void patchcategory()async{
    String  text = nameController.text.trim();
    String categoryid = categoryIdcontoller.text.trim();

    try{
      FormData formData = FormData.fromMap({
        "category_id":indx,
        "name" : text,

      });
      Response response = await dioClient.ref.patch("/category/",data: formData

      );
      setState(() {
        updatecategory = patchCategoryFromJson(jsonEncode(response.data));

        print(response.data);
        patchresponse=response.data["message"];
      });
    }
    catch(e){

    }
  }
  _patchDialog(BuildContext context) async  {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Patch Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextField(
                    //     controller: categoryIdcontoller,
                    //     decoration: InputDecoration(
                    //         hintText: "Enter category id"
                    //     ),
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Enter Category Name"
                        ),
                      ),
                    ),
                    RaisedButton(
                        child: Text("click to update"),
                        onPressed: (){
                          patchcategory();
                          setState(() {

                          });
                        }),
                    // patchresponse==null?Text("enter valid id"):Text(patchresponse),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
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

  void deletecategory() async {
    String  number = idcontroller.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "category_id" :categoryindx
      });
      Response response = await dioClient.ref.delete("/category/",data: formData

      );
      setState(() {
        deletecatg = daleteCategoryFromJson(jsonEncode(response.data));
        print(response.data["message"]);
        respo=response.data["message"];
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  _deletecategory(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: idcontroller,
                        decoration: InputDecoration(
                            hintText: "Enter id "
                        ),
                      ),
                    ),
                    RaisedButton(
                        child: Text("click to delete"),
                        onPressed: (){
                          deletecategory();
                          setState(() {

                          });
                        }),
                    respo == null ?Text("enter valid id") :Text("category --- ${respo}"),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              ),
              // respo == null ?Text("enter valid id") :Text("test --- ${respo}"),
            ],
          );
        });
  }

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


  final channelname=TextEditingController();
  final description = TextEditingController();
  final category_id=TextEditingController();
  void channelsadd()async{
    String  name = channelname.text.trim();
    String descriptions = description.text.trim();


    try{
      final formData = FormData.fromMap({
        "name" : name,
        "banner":await MultipartFile.fromFile(bannerimage!.path),
        "profile_pic":await MultipartFile.fromFile(image!.path),
        "description":descriptions,
        "category_id":indx
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
  _addchannel(BuildContext context) async {
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
                        controller: channelname,
                        decoration: InputDecoration(
                            hintText: "Enter Name"
                        ),
                      ),
                    ),
                    RaisedButton(
                        child: Text("upload"),
                        onPressed: (){
                          setState(() {
                            filepicker();
                          });
                        }),
                    RaisedButton(
                        child: Text("upload"),
                        onPressed: (){
                          setState(() {
                            bannerpicker();
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
                          channelsadd();
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
  final channeledit=TextEditingController();
  final channelId=TextEditingController();

  void patchchannel()async{
    String  channelname = channeledit.text.trim();
    String categoryid = channelId.text.trim();

    try{
      FormData formData = FormData.fromMap({
        "category_id":channelindx,
        "name" : channelname,

      });
      Response response = await dioClient.ref.patch("/channel/",data: formData

      );
      setState(() {
        patchchannels = patchChannelFromJson(jsonEncode(response.data));

        print(response.data);
        patchresponse=response.data["message"];

      });
    }
    catch(e){

    }
  }
  _patchChannels(BuildContext context) async  {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Patch channel'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller:channeledit,
                        decoration: InputDecoration(
                            hintText: "Enter Channel Name"
                        ),
                      ),
                    ),
                    RaisedButton(
                        child: Text("click to update"),
                        onPressed: (){
                          patchchannel();
                          setState(() {

                          });
                        }),
                    // patchresponse==null?Text("enter valid id"):Text(patchresponse),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
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

  void deletechannel() async {
   // String chid = channelidcontroller.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "channel_id" :channelindx
      });
      Response response = await dioClient.ref.delete("/channel/?channel_id=${channelindx}",data: formData

      );
      setState(() {
        deletechannels = deleteChannelFromJson(jsonEncode(response.data));
        print(response.data["message"]);
        respo=response.data["message"];
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  _deletechannel(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextField(
                    //     controller: idcontroller,
                    //     decoration: InputDecoration(
                    //         hintText: "Enter id "
                    //     ),
                    //   ),
                    // ),
                    RaisedButton(
                        child: Text("click to delete"),
                        onPressed: (){
                          deletechannel();
                          setState(() {

                          });
                        }),
                    respo == null ?Text("enter valid id") :Text("category --- ${respo}"),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              ),
              // respo == null ?Text("enter valid id") :Text("test --- ${respo}"),
            ],
          );
        });
  }



  @override
  void initState() {
    //fetch_genres();
    fetch_categories();
    addcategory();
    fetch_channels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                              _patchDialog(context);
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(width: 10,),
                      ],
                    )
                  ],
                ),
                userdata(),
                SizedBox(height: 20,),



                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Channels",style: TextStyle(color: Colors.amber,fontSize: 18,fontWeight: FontWeight.w600),)),
                SizedBox(height: 20,),
                channeldata(),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      _addchannel(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:Colors.pinkAccent),
                      child: Text("Add Channel",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w700),),
                    ),
                  ),
                ),

              ],
            ),
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
    return  SizedBox(
      height: 80,
      child: ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        itemCount: allcategories?.videos.length,
        //itemCount: news!.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          //CategoriesModel current= allcategories!;
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: InkWell(
                  onLongPress: (){
                    _deletecategory(context);
                    setState(() {
                      categoryindx=allcategories!.videos[index].categoryId;
                    });
                  },
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        indx=allcategories?.videos[index].categoryId;
                        fetch_channels();

                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: indx != allcategories!.videos[index].categoryId?BoxDecoration():BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.pink
                        ),
                        child: Column(
                          children: [
                            Text(allcategories!.videos[index].name),
                            Text("index is ${allcategories!.videos[index].categoryId}"),
                            Text("${indx}")
                          ],
                        )),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
  Widget channeldata () {
    if(_fetching){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // return Center(child: Text(categories?.categoryName));
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount:channels?.videos?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){

        return InkWell(
          onLongPress: (){
            _deletechannel(context);
            setState(() {
              channelindx=channels!.videos![index].channelId;
            });
          },
          child: InkWell(
            onTap: (){
              channelindx=channels!.videos![index].channelId;
            },
            child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(channels?.videos?[index].name??" "),
                        SizedBox(height: 20,),
                        Text(channels!.videos![index].description),
                        Text("category id are ${channelindx}")
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
                          image: DecorationImage(
                              image: NetworkImage("https://sowmyamatsa.pythonanywhere.com/${channels!.videos![index].profilePic}"),
                              fit: BoxFit.cover
                          )
                      ),
                      height: 50,
                      width: 50,

                    ),
                    InkWell(
                      onTap: (){
                        _patchChannels(context);
                      },
                      child: Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey),
                        child: Icon(Icons.edit,size: 20,),
                      ),
                    ),

                  ],
                )
            ),
          ),
        );
      },
    );
  }
}