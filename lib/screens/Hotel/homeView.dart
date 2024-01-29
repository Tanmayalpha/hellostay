import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hellostay/constants/colors.dart';
import 'package:hellostay/utils/date_function.dart';
import 'package:hellostay/utils/traver_tile.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import 'calender_view.dart';

final List rooms = [
  {
    "image":
    "https://cdn.britannica.com/96/115096-050-5AFDAF5D/Bellagio-Hotel-Casino-Las-Vegas.jpg",
    "title": "Peaceful Room"
  },
  {
    "image":
    "https://images.unsplash.com/photo-1625244724120-1fd1d34d00f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWxzfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "title": "Peaceful Room"
  },
  {
    "image":
    "https://23c133e0c1637be1e07d-be55c16c6d91e6ac40d594f7e280b390.ssl.cf1.rackcdn.com/u/gpch/Park-Hotel-Group---Explore---Grand-Park-City-Hall-Facade.jpg",
    "title": "Beautiful Room"
  },
  {
    "image":
    "https://cdn.britannica.com/96/115096-050-5AFDAF5D/Bellagio-Hotel-Casino-Las-Vegas.jpg",
    "title": "Vintage room near Pashupatinath"
  },
];

DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now().add(const Duration(days: 5));

bool isDatePopupOpen = false;

class HotelHomePage extends StatefulWidget {
  static const String path = "lib/src/pages/hotel/hhome.dart";

  @override
  State<HotelHomePage> createState() => _HotelHomePageState();
}

int roomCount = 0;
int peopleCount = 0;
int childCount = 0;

final checkInC = TextEditingController();
final checkOutC = TextEditingController();
final searchC = TextEditingController();

String? checkInDate  = '' ;
String? checkOutDate  = '' ;

//CityListResponse? cityListResponse;
dynamic cityListResponse;

class _HotelHomePageState extends State<HotelHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    getCityList();
    super.initState();
  }

 // Payload? cityId;


  /*static String _displayStringForOption(Payload option) =>
      option.name ?? '';*/
  TextEditingController citySearchC =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: Colors.red,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
            floating: false,
            flexibleSpace: ListView(
              children:  <Widget>[
                const SizedBox(height: 40,),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.3,
                width: MediaQuery.of(context).size.width / 1,
                child: Stack(
                  children: [
                    Positioned(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/loginImage.png'),
                                  fit: BoxFit.contain)),
                        )),
                    /* Positioned(
                              height: MediaQuery.of(context).size.height / 5.0,
                              width: MediaQuery.of(context).size.width / 1,
                              child: Image.asset(
                                "assets/images/airplane.png",
                                height: 50,
                                width: 50,
                              )),*/
                  ],
                ),
              ),

                /*Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: Autocomplete<Payload>(
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) =>
                        TextField(
                          onChanged: (v){
                            searchApi(v);
                          },
                          controller: textEditingController,
                          onEditingComplete: onFieldSubmitted,
                          focusNode: focusNode,

                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                            ),
                            hintText: "Search City",
                            border: InputBorder.none,

                          ),
                        ),
                    displayStringForOption: _displayStringForOption,
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Payload> onSelected,
                        Iterable<Payload> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),

                          child: SizedBox(
                            width: 300,
                            height: 500,

                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(10.0),
                              itemCount: citySearchModel?.payload?.length ?? 0 ,
                              itemBuilder: (BuildContext context, int index) {
                                final Payload? option =
                                citySearchModel?.payload?[index];

                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option ?? Payload());
                                  },
                                  child: ListTile(
                                    minLeadingWidth: 10,
                                    leading:
                                    const Icon(Icons.location_on_outlined),
                                    title: Text(option?.name ?? '',
                                        style: const TextStyle(
                                            color: colors.black54)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text == '') {
                        return const Iterable<Payload>.empty();
                      }
                      return citySearchModel?.payload!.toList() ??
                          [];
                    },
                    onSelected: (Payload selection) {
                      debugPrint('You just selected ${selection.name}');
                      cityId = selection;
                    },
                  ),
                ),*/

              ],
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15.0,
            ),
          ),
          /*SliverToBoxAdapter(
            child: getTimeDateUI(context),
          ),*/
          const SliverToBoxAdapter(child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Book on India's Largest Hotel Network", style: TextStyle(fontSize: 25),),
          ),),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Select City, Location or Hotel Name(Worldwide)", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black54.withOpacity(0.4)),),
            ),
          ),
           SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                readOnly: true,
                controller: searchC,
                onTap: () {
                  /* var result = ShowListForm();
                              if (result != "" ||
                                  result != null) {
                                fromcitycontroller =
                                    TextEditingController(
                                        text: result
                                            .toString());
                              }*/
                },
                textAlign: TextAlign.left,
                decoration:  InputDecoration(
                    hintText: 'Select',
                    hintStyle: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black54
                            .withOpacity(0.4))
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: () async{
                      String date = await selectDate(context);

                      formattedCheckInDate = DateFormat("dd MMM''yy").format(DateTime.parse(date));
                      checkInDayOfWeek = DateFormat("EEEE").format(DateTime.parse(date));
                      setState(() {
                        isCheckInSelected = true ;
                        isCheckOutSelected = false ;
                      });
                    },
                      child: selectDateWidget( 'Check-in', checkInDayOfWeek, formattedCheckInDate,isCheckInSelected)),
                  InkWell(
                    onTap: () async{
                      String date = await selectDate(context);

                      formattedCheckOutDate = DateFormat("dd MMM''yy").format(DateTime.parse(date));
                      checkOutDayOfWeek = DateFormat("EEEE").format(DateTime.parse(date));
                      setState(() {
                        isCheckInSelected = false;
                        isCheckOutSelected = true ;
                      });
                    },
                      child: selectDateWidget( 'Check-Out',checkOutDayOfWeek, formattedCheckOutDate,isCheckOutSelected)),
                  /*Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                       Text("Check-in",style: TextStyle(color: Colors.black54
                          .withOpacity(0.4)),),
                      SizedBox(
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            2.5,
                        child: TextFormField(
                          readOnly: true,
                          controller: checkInC,
                          onTap: () {
                           */
                  /*Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                       Text("Check-out",style: TextStyle(color: Colors.black54
                          .withOpacity(0.4))),
                      SizedBox(
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            2.5,
                        child: TextFormField(
                          readOnly: true,
                          controller: checkOutC,
                          onTap: () async{

                            String date = await selectDate(context);

                           // String _dateValue = convertDateTimeDisplay(date);
                            String dateFormate = DateFormat("dd MMM''yy, EEEE").format(DateTime.parse(date ?? ""));

                            checkOutC.text =  dateFormate;

                            print(dateFormate) ;
                          },
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              hintText: 'Select',
                              hintStyle: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black54
                                      .withOpacity(0.4))),
                        ),
                      )
                    ],
                  )*/
                ],
              ),
            ),
          ),
       SliverToBoxAdapter(child: TravelDetailsTile(),),

          SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return _buildRooms(context, index);
            }, childCount: 100),
          )
        ],
      ),
    );
  }

 // CitySearchModel? citySearchModel;
  dynamic citySearchModel;
  searchApi(String value) async {
    print('_____aaaa_____${value}_________');
    var headers = {
      'apikey': 'apiKey'
    };
    var request = http.Request('GET', Uri.parse('https://apitest.tripjack.com/xms/v1/searchApi/tjs_multicity_cities-info/${value}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult =  await response.stream.bytesToString();
      //var jsonResponse =  CitySearchModel.fromJson(json.decode(finalResult));
      setState(() {
       // citySearchModel = jsonResponse;
      //  print('_____finalResult_____${finalResult}_________');

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  getCityList() async {
    var headers = {'apikey': 'apiKey'};
    var request =
    http.Request('GET', Uri.parse('${'flightUrl'}/hms/v1/static-cities/'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();

   //   final jsonResponse = CityListResponse.fromJson(json.decode(finalResult));
      setState(() {
      //  cityListResponse = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget _buildRooms(BuildContext context, int index) {
    var room = rooms[index % rooms.length];
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.network(room['image']),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Icon(
                        Icons.star,
                        color: Colors.grey.shade800,
                        size: 20.0,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Icon(
                        Icons.star_border,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        child: Text("\$40"),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        room['title'],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Bouddha, Kathmandu"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "(220 reviews)",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int adultCount = 1;
  int childrenCount = 0;
  List<int> childrenAges = List.filled(0, 0);


  Widget travelerTile(){
    return ExpansionTile(
      title: Text('Traveler Count: $adultCount Adult(s), $childrenCount Children(s)'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIncrementDecrement('Adults', adultCount, (value) {
              setState(() {
                adultCount = value;
              });
            }),
            _buildIncrementDecrement('Children', childrenCount, (value) {
              setState(() {
                childrenCount = value;
                childrenAges = List.filled(value, 0);
              });
            }),
          ],
        ),
        if (childrenCount > 0) ..._buildChildrenDropdowns(),
      ],
    );
  }

  List<Widget> _buildChildrenDropdowns() {
    List<Widget> dropdowns = [];
    for (int i = 0; i < childrenCount; i++) {
      dropdowns.add(
        Row(
          children: [
            Text('Child ${i + 1} Age:'),
            SizedBox(width: 10),
            DropdownButton<int>(
              value: childrenAges[i],
              onChanged: (value) {
                setState(() {
                  childrenAges[i] = value!;
                });
              },
              items: List.generate(18, (index) => index + 1)
                  .map((age) => DropdownMenuItem<int>(
                value: age,
                child: Text('$age'),
              ))
                  .toList(),
            ),
          ],
        ),
      );
    }
    return dropdowns;
  }

  Widget _buildIncrementDecrement(String label, int count, Function(int) onChanged) {
    return Column(
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (count > 0) {
                  onChanged(count - 1);
                }
              },
            ),
            Text('$count'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onChanged(count + 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          Category(
            backgroundColor: Colors.pink,
            icon: Icons.hotel,
            title: "Hotel",
          ),
          SizedBox(
            width: 15.0,
          ),
          Category(
            backgroundColor: Colors.blue,
            title: "Restaurant",
            icon: Icons.restaurant,
          ),
          SizedBox(
            width: 15.0,
          ),
          Category(
            icon: Icons.local_cafe,
            backgroundColor: Colors.orange,
            title: "Cafe",
          )
        ],
      ),
    );
  }



  Widget getTimeDateUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        isDatePopupOpen = true;
                      });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (false/*cityId == null*/) {
                        Fluttertoast.showToast(msg: 'please select city first');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => showPeopleDialouge(context),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${peopleCount} Adults - ${childCount} Child',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showPeopleDialouge(BuildContext cntxtt) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Align(
            alignment: Alignment.topCenter, child: Text('Room Selected')),
        titlePadding: const EdgeInsets.only(top: 10),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adults'),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                peopleCount++;
                              });
                            },
                            child: const Icon(Icons.add_circle_outline)),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${peopleCount}'),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (peopleCount > 0) {
                                  peopleCount--;
                                }
                              });
                            },
                            child: Icon(Icons.remove_circle_outline)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Child'),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                childCount++;
                              });
                            },
                            child: Icon(Icons.add_circle_outline)),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${childCount}'),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (childCount > 0) {
                                  childCount--;
                                }
                              });
                            },
                            child: Icon(Icons.remove_circle_outline)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnaheimScreen(
                              child: childCount,
                              adults: peopleCount,
                              title: cityId?.name ?? '',
                              checkIn:
                              DateFormat('yyyy-MM-dd').format(startDate),
                              checkOut:
                              DateFormat('yyyy-MM-dd').format(endDate),
                              cityId: cityId?.code.toString(),
                            ),
                          ));*/
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text('Apply')),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  String formattedCheckInDate = '';
  String formattedCheckOutDate = '';
  String dayOfWeek= '';
  String checkInDayOfWeek= '';
  String checkOutDayOfWeek= '';
  bool isCheckInSelected = false ;
  bool isCheckOutSelected = false ;

  Widget selectDateWidget (String title, String checkInDayOfWeek, String formattedCheckInDate, bool isSelected){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.primary : Colors.black54.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 8),
        checkInDayOfWeek == ''  ? const Text('Select Date') : RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$formattedCheckInDate\n',
                style: const TextStyle(
                  fontSize: 20,
                  color:  AppColors.blackTemp,
                ),
              ),
              TextSpan(
                text: checkInDayOfWeek,
                style: const TextStyle(
                  fontSize: 14,
                  color:  Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width/2.5,
          color: isSelected ?  AppColors.primary : Colors.grey,
        ),
      ],
    );
  }

/* Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1 Room - 2 Adults',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}

class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? backgroundColor;

  const Category(
      {Key? key, required this.icon, required this.title, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(title, style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
