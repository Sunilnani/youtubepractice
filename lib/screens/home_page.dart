import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_practice/models/add_category.dart';
import 'package:youtube_practice/models/categoriesmodel.dart';
import 'package:youtube_practice/models/channelsmodel.dart';
import 'package:youtube_practice/models/delete_catg_model.dart';
import 'package:youtube_practice/models/patch_category_model.dart';

import 'package:youtube_practice/network_calls/base_networks.dart';
 import 'package:youtube_practice/models/categoriesmodel.dart';
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

  CategoriesModel? allcategories;

  ChannelModel? channels;

  dynamic res ;
  dynamic patchresponse;
  dynamic respo;

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
        print("categories index is ${categoryindx}");



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

  void addcategory()async{
    String text = nameController.text.trim();
    FormData data = FormData.fromMap({
      "name":text,
    });
    Response response = await dioClient.ref.post("/category/",data: data

    );
    setState(() {
      addcategories = categoryAddModelFromJson(jsonEncode(response.data));

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
        "category_id":categoryid,
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

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: categoryIdcontoller,
                        decoration: InputDecoration(
                            hintText: "Enter category id"
                        ),
                      ),
                    ),
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

  void fetch_channels() async {
    setState(() {
      _fetching = true;
    });
    try {

      Response response = await dioClient.ref.get("/category_channels/?category_id=1",

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
                        // InkWell(
                        //   onLongPress: (){
                        //     //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideosPage()));
                        //     _deletecategory(context);
                        //   },
                        //     child: Icon(Icons.delete))
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
        itemCount: allcategories!.videos.length,
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
                        indx=allcategories!.videos[index].categoryId;

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
      itemCount:channels!.videos.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,index){

        return InkWell(
            onTap: (){
              setState(() {
               channelindx=channels!.videos[index].categoryId;
              });
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
                  Text(channels!.videos[index].name),
                  SizedBox(height: 20,),
                  Text(channels!.videos[index].description),
                  Text("category id are ${channelindx}")
                ],
              ),
               Spacer(),
               Container(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
                     image: DecorationImage(
                         image: NetworkImage("https://sowmyamatsa.pythonanywhere.com/${channels!.videos[index].profilePic}"),
                         fit: BoxFit.cover
                     )
                 ),
                 height: 50,
                 width: 50,

               ),

          ],
        )
          ),
        );
      },
    );
  }
}
