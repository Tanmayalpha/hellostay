import 'package:flutter/material.dart';
import 'package:hellostay/repository/apiBasehelper.dart';
import 'package:hellostay/screens/Hotel/homeView.dart';
import 'package:hellostay/utils/sharedPreference.dart';
import 'package:hellostay/widgets/custom_nav_bar.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return  HotelHomePage();
        break;
      case 1:
       // Common.checkLogin(context);
        return const Center(child: Text('Message'),);
        break;

      case 2:
       // Common.checkLogin(context);
        return const Center(child: Text('Trip Screen'),);
        break;

      case 3:
       // Common.checkLogin(context);
        return const Center(child: Text('Booking'),);/*const BookingScreen(
            *//*idUser: widget.userID,*//*
            )*/;
        break;

      case 4:
       // Common.checkLogin(context);
        return Center(child: Text('Profile'),);/*const ProfileScreen(
            *//*userID: widget.userID,*//*
            );*/
        break;
      default:
        return const Center(child: Text('Home'),);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  getProfile() async {
    await App.init();
    Map response =
        await apiBaseHelper.getAPICall(Uri.parse("${'baseUrl'}auth/me"));

    if (response['data'] != null) {
     // name = response['data']['name'] ?? "";
    //  firstName = response['data']['first_name'] ?? "";
     // lastName = response['data']['last_name'] ?? "";
     // email = response['data']['email'] ?? "";
     // profile = response['data']['avatar_url'] ?? "";
    //  password = App.localStorage.getString("password") ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: callPage(currentIndex),
        bottomNavigationBar: BottomNavigationDotBar(
            color: Colors.black26,

            items: <BottomNavigationDotBarItem>[
              BottomNavigationDotBarItem(
                  icon: const IconData(0xe900, fontFamily: 'home'),
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(0xe900, fontFamily: 'message'),
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(
                    0xe900,
                    fontFamily: 'trip',
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(
                    0xe900,
                    fontFamily: 'hearth',
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(0xe900, fontFamily: 'profile'),
                  onTap: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  }),
            ]));
  }
}
