// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_practice/models/categoriesmodel.dart';
// import 'package:youtube_practice/models/category_model.dart';
// import 'package:youtube_practice/network_calls/base_networks.dart';
// import 'package:youtube_practice/screens/channelpage.dart';
//
// class VideosPage extends StatefulWidget {
//
//   @override
//   _VideosPageState createState() => _VideosPageState();
// }
//
// class _VideosPageState extends State<VideosPage> {
//   bool _fetching = true;
//
//   //categoriesModel? categories;
//   CategoriesModel? allcategories;
//   List<Video>? videos;
//   final nameController=TextEditingController();
//   CategoryModel? addcategory;
//
//
//   void fetch_categories() async {
//     setState(() {
//       _fetching = true;
//     });
//     try {
//
//       Response response = await dioClient.ref.get("/categories/",
//
//       );
//       setState(() {
//         allcategories = categoriesModelFromJson(jsonEncode(response.data));
//         _fetching = false;
//         //print(categories!.totalCount);
//         // print("token here is ${access}");
//
//       });
//       print(response);
//     } catch (e) {
//       setState(() {
//         _fetching = false;
//       });
//       print(e);
//     }
//   }
//
//   void categoryadd()async{
//     String  name = nameController.text.trim();
//
//     try{
//       final formData = FormData.fromMap({
//         "name" : name,
//         //"image":await MultipartFile.fromFile(productimag.path)
//       });
//       Response response = await dioClient.ref.post("/category/",data: formData
//
//       );
//       setState(() {
//        addcategory= categoryModelFromJson(jsonEncode(response.data)) ;
//         print(response.data["message"]);
//         //responses=response.data["message"];
//       });
//     }
//     catch(e){
//
//     }
//   }
//
//
//   @override
//   void initState() {
//     fetch_categories();
//     categoryadd();
//     //fetch_newsfeed();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             userdata(),
//             InkWell(
//               onTap: (){
//                 _addproduct(context);
//               },
//               child: Container(
//                 height: 30,
//                 width: 35,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.tealAccent),
//                 child: Icon(Icons.add,size: 20,),
//               ),
//             ),
//             InkWell(
//               onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChannelPage()));
//               },
//                 child: Text("add channels ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 20),))
//           ],
//         ),
//       ),
//     );
//   }
//   Widget userdata (){
//     if(_fetching){
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     // return Center(child: Text(categories?.categoryName));
//     return   ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: allcategories!.videos.length,
//       //itemCount: news!.length,
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemBuilder: (context,index){
//         // return Text(categories!.videos[index].name);
//         return Text(allcategories!.videos[index].name);
//       },
//     );
//   }
//   _addproduct(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Add Product'),
//             content: Container(
//               height: 150,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: TextField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                             hintText: "Enter Name"
//                         ),
//                       ),
//                     ),
//                     // responses==null ?Text("enter valid details"):Text(responses),
//                   ],
//                 ),
//               ),
//             ),
//             actions: <Widget>[
//               new FlatButton(
//                 child: new Text('Ok'),
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => VideosPage(
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
