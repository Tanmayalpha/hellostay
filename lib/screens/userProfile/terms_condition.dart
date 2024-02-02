import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hellostay/constants/colors.dart';
import 'package:hellostay/model/PrivacyModel.dart';
import 'package:hellostay/repository/apiConstants.dart';
import 'package:http/http.dart' as http;

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {

  String? terms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
  }
  PrivacyModel? privacyModel;

  getApi() async
  {
    var request = http.Request('GET', Uri.parse('${baseUrl1}page/terms-and-conditions')); http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("aaa");
      var result = await response.stream.bytesToString();
      print("kkk");
      var finaResult = jsonDecode(result);
      print("cccc");
      //  print(await response.stream.bytesToString());
      setState(() {
        terms=finaResult['data']['row']['content'].toString();
        print(terms);
      });


    }
    else {
      print(response.reasonPhrase);
      print("api not run");
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.whiteTemp,
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteTemp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Terms & Condition',
          style: TextStyle(fontFamily: "Sofia", color: AppColors.whiteTemp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            terms==null||terms==""?Center(child: CircularProgressIndicator(color: Colors.black,),):
            Html(data: "${terms}")
          ],
        ),
      ),
    );
  }
}
