import 'package:flutter/material.dart';
import 'package:hellostay/constants/colors.dart';
import 'package:hellostay/repository/apiConstants.dart';
import 'package:hellostay/repository/apiStrings.dart';
import 'package:hellostay/utils/customeTost.dart';
import 'package:hellostay/widgets/custom_app_button.dart';
import 'package:hellostay/widgets/custumScreen.dart';
import 'package:hellostay/widgets/loadingwidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';



class VerifyOtp extends StatefulWidget {
  bool? isLogin;
  String? otp;
  String? mobile;
  VerifyOtp({super.key, this.otp, this.mobile, this.isLogin});
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customAuthDegineforverifie(
            context,
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29),
            height: MediaQuery.of(context).size.height * 0.69,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Code has sent to',
                      style: TextStyle(
                          fontSize: 17,
                          color: AppColors.blackTemp,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 2,
                  ),
                  Text('+${widget.mobile.toString()}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.blackTemp,
                          fontWeight: FontWeight.w400)),
                  Text('OTP: ${otp.toString()}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.blackTemp,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: PinCodeTextField(
                      keyboardType: TextInputType.phone,

                      onChanged: (value) {
                        textotp = value.toString();
                      },

                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        activeColor: AppColors.secondary,
                        inactiveColor: AppColors.primary,
                        selectedColor: AppColors.secondary,
                        fieldHeight: 70,
                        fieldWidth: 70,

                      ),
                      //pinBoxRadius:20,
                      appContext: context,
                      length: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text("Haven't received the verification code?",
                      style: TextStyle(
                          fontSize: 17,
                          color: AppColors.blackTemp,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 5,
                  ),
                  !isLoading
                      ? InkWell(
                          onTap: () {
                            sendOtp();
                          },
                          child: const Text("Resend",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: AppColors.blackTemp,
                                  fontWeight: FontWeight.bold)))
                      : LoadingWidget(context),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                      onTap: () {

                        if (textotp == null) {
                          customSnackbar(context, "Please Fill OTP Fields");
                        } else if (otp != textotp) {
                          customSnackbar(context, "Please Fill Correct OTP");
                        } else {
                          if(widget.isLogin==true){
                            verifie();

                          }
                          else{


                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePassword(
                                      Mobile: widget.Mobile.toString()),
                                ));*/


                          }



                        }
                      },
                      child: CustomButton(
                        textt: "Submit",
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCM();
    otp = widget.otp.toString();

  }

  bool isLoading = false;
  var otp;
  var textotp;



  void sendOtp() {
    setState(() {
      isLoading = true;
    });
    var param = {
      "user_phone": widget.mobile.toString(),
    };
    apiBaseHelper.postAPICall(loginApi, param).then((getData) {
      String msg = getData['message'];
      bool error = getData['status'];

      if (error == true) {
        setState(() {
          otp = getData['data'].toString();
        });
        customSnackbar(context, msg.toString());
        setState(() {
          isLoading = false;
        });
      } else {
        customSnackbar(context, msg.toString());

        setState(() {
          isLoading = false;
        });
      }
    });
  }


  String? fcmToken;
  getFCM() async {
    /*final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try {
      fcmToken = await _firebaseMessaging.getToken() ?? "";
    } on FirebaseException {}*/
  }
  void verifie() {
    setState(() {
      isLoading = true;
    });
    var param = {
      "user_phone": widget.mobile.toString(),
      'otp':otp.toString(),
      'firebaseToken':fcmToken.toString()
    };
    apiBaseHelper.postAPICall(loginApi, param).then((getData) async {
      String msg = getData['message'];
      bool error = getData['status'];

      if (error == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', '${getData['data']['id']}');
        if(mounted){
        customSnackbar(context, msg.toString()); }

       /* Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard(),));*/
        setState(() {
          isLoading = false;
        });
      } else {
        customSnackbar(context, msg.toString());

        setState(() {
          isLoading = false;
        });
      }
    });
  }


}
