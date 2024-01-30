import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellostay/repository/apiConstants.dart';
import 'package:hellostay/screens/userProfile/updateProfiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import 'package:http/http.dart'as http;

import '../../model/getProfineModel.dart';
import '../bottom_nav/bottom_Nav_bar.dart';
import '../loginScreen.dart';

class MyprofileScr extends StatefulWidget {
  const MyprofileScr({Key? key}) : super(key: key);

  @override
  State<MyprofileScr> createState() => _MyprofileScrState();
}

class _MyprofileScrState extends State<MyprofileScr> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar:
   PreferredSize(preferredSize:Size.fromHeight(80),
   child:  Container(
     color: AppColors.primary,
     height: 80,width: MediaQuery.of(context).size.width,
   child: Padding(
     padding: const EdgeInsets.all(5),
     child: Row(children: [
       SizedBox(width: 15,),
       CircleAvatar(
         radius: 28,
         child: CircleAvatar(
           backgroundImage: NetworkImage('${getUserData?.data.avatarUrl??""}'),
           child: Center(child: Icon(Icons.person,size: 30,),),
           radius: 25,),
       ),

      SizedBox(width: 20,),

       token==null?
       InkWell(
           onTap: () {

             Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
           },
           child: Text("login/Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: AppColors.white),)):


       Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [


          Text("${getUserData?.data.firstName??""} ${getUserData?.data.lastName??""}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: AppColors.white),),
         Text("${getUserData?.data.email??""}",style: TextStyle(fontSize: 12,color: AppColors.white),),



       ],),
Spacer(),
       token==null?SizedBox():
       InkWell(
         onTap: () {

           Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(),));
         },
           child: Icon(Icons.edit,color: AppColors.white,)),
     ]),
   ),
   ),),
    body:

    isLoading?Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
    child: Center(child: CircularProgressIndicator(),),
    ):
    SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20,left: 5,right: 5),
      child: Column(children: [
        tabProfile(context,"Notification"),
        tabProfile(context,"Wallet"),
        // tabProfile(context,"Privecy"),
        // tabProfile(context,"Wallet"),
        // tabProfile(context,"Wallet"),
        // tabProfile(context,"Wallet"),
        InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Are you sure to Logout?"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primary),
                          child: const Text("YES"),
                          onPressed: () async {
                            setState(() {
                              sessionremove();
                            });
                            Navigator.pop(context);
                            // SystemNavigator.pop();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomNavBar(),
                                ));
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primary),
                          child: const Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });

            },
            child: tabProfile(context,"Log out")),


      ]),
    ),),
    ));
  }

  Widget tabProfile(BuildContext context,String tabName){


    return
      Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),),
        elevation: 2,
        child:

        Container (height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),


          child:


          Row(children: [

            SizedBox(width: 15,),

            Text("${tabName}",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.tabtextColor,fontSize: 15),),
            Spacer(),
            Icon(Icons.arrow_forward_ios,color: AppColors.blackTemp,size: 16,),
            SizedBox(width: 5,),


          ]),),

      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    gettoken();
    super.initState();
  }
  var token;
  Future<void> gettoken() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token= await prefs.getString('userToken');
    print("===my technic=======${token}===============");
    setState(() {

    });
    if(token==null){

      setState(() {
        isLoading=false;
      });
    }else {
      getUserDataaa();
    }
  }

  GetUserData?getUserData;
  Future<void> getUserDataaa() async {


    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${baseUrl}me'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      print("===my technic=======${result}===============");
      var finalresult=jsonDecode(result);

      if(finalresult['status']==1){
        setState(() {
        getUserData=GetUserData.fromJson(finalresult);

          isLoading = false;
        });

      }
    }
    else {
    print(response.reasonPhrase);
    }

  }

  bool isLoading=false;
Future<void> sessionremove() async {

  setState(() {
    isLoading=true;
  });
  final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.remove('userToken');
  setState(() {
    isLoading=false;
  });
}

}
