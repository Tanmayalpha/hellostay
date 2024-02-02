import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hellostay/constants/colors.dart';
import 'package:hellostay/model/trendingHotelModel.dart';
import 'package:hellostay/repository/apiConstants.dart';
import 'package:hellostay/screens/Hotel/hotel_list_View.dart';
import 'package:hellostay/utils/address_search.dart';
import 'package:hellostay/utils/date_function.dart';
import 'package:hellostay/utils/place_service.dart';
import 'package:hellostay/utils/traver_tile.dart';
import 'package:hellostay/widgets/custom_app_button.dart';
import 'package:hellostay/widgets/select_date_widget.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
String formattedCheckInDate = '';
String formattedCheckOutDate = '';
String checkInDayOfWeek= '';
String checkOutDayOfWeek= '';

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

String checkInDate  = '' ;
String checkOutDate  = '' ;


//CityListResponse? cityListResponse;
dynamic cityListResponse;

class _HotelHomePageState extends State<HotelHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    //getCityList();
    super.initState();

    checkInDate = DateTime.now().toString();
    checkOutDate =  DateTime.now().add(const Duration(days: 1)).toString();
    formattedCheckInDate = DateFormat("dd MMM''yy").format(DateTime.parse(checkInDate));
    checkInDayOfWeek = DateFormat("EEEE").format(DateTime.parse(checkInDate));
    formattedCheckOutDate = DateFormat("dd MMM''yy").format(DateTime.parse(checkOutDate));
    checkOutDayOfWeek = DateFormat("EEEE").format(DateTime.parse(checkOutDate));
    trendingHotel();
    getLocationApi();
  }

 // Payload? cityId;


  /*static String _displayStringForOption(Payload option) =>
      option.name ?? '';*/
 // TextEditingController citySearchC =  TextEditingController();
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  int adultCount = 1;
  int childrenCount = 0;
  List<int> childrenAges = List.filled(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: (){

          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => HotelSearchScreen(
                              children: childrenCount,
                              adults: adultCount,
                              //title: cityId?.name ?? '',
                              checkIn: DateFormat('yyyy-MM-dd').format(DateTime.parse(checkInDate)),
                              checkOut: DateFormat('yyyy-MM-dd').format(DateTime.parse(checkOutDate)),
                              address: _controller.text, lat: '', long: '',
                            ),
                          ));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,08,20,08),
          child: CustomButton(textt: 'Book Now'),
        ),
      ),
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
                onTap: () async{
                  final sessionToken = const Uuid().v4();
                  final Suggestion? result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  if (result != null) {

                    final placeDetails = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);


                    searchC.text = result.description;
                    _streetNumber = placeDetails.streetNumber ?? '';
                    _street = placeDetails.street ??'';
                    _city = placeDetails.city?? '';
                    _zipCode = placeDetails.zipCode??'';
                    setState(() {
                      _controller.text = result.description;
                    });
                  }
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
          SliverToBoxAdapter(child: TravelDetailsTile(isFromHome: true),),
          const SliverToBoxAdapter(child: Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Divider(),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding:  const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: () async{
                      String date = await selectDate(context);

                      checkInDate = date ;

                      formattedCheckInDate = DateFormat("dd MMM''yy").format(DateTime.parse(date));
                      checkInDayOfWeek = DateFormat("EEEE").format(DateTime.parse(date));
                      setState(() {
                        isCheckInSelected = true ;
                        isCheckOutSelected = false ;
                      });
                    },
                      child: selectDateWidget( 'Check-in', checkInDayOfWeek, formattedCheckInDate,isCheckInSelected, context)),
                  const Icon(Icons.nights_stay, color: AppColors.faqanswerColor,),
                  InkWell(
                    onTap: () async{
                      String date = await selectDate(context);
                      checkOutDate = date ;


                      formattedCheckOutDate = DateFormat("dd MMM''yy").format(DateTime.parse(date));
                      checkOutDayOfWeek = DateFormat("EEEE").format(DateTime.parse(date));
                      setState(() {
                        isCheckInSelected = false;
                        isCheckOutSelected = true ;
                      });
                    },
                      child: selectDateWidget( 'Check-Out',checkOutDayOfWeek, formattedCheckOutDate,isCheckOutSelected, context)),
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

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Top Destinations",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),
          SliverToBoxAdapter(child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(children: List<Widget>.generate(images.length, (index) =>_buildRooms(context,index) ))),),
          const SliverToBoxAdapter(child: SizedBox(height: 10),),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Trending",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),

          SliverToBoxAdapter(child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              itemCount: imageTrendingModel?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _buildRooms2(context,index),
              staggeredTileBuilder: (index) {
          return  StaggeredTile.count(1, index.isEven ? 1.5 : 1.8);
          })
                ),

          /*SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return _buildRooms(context, index);
            }, childCount: 100,),
          )*/
        ],
      ),
    );
  }

 // CitySearchModel? citySearchModel;
  dynamic citySearchModel;
  TrendingHotelModel? imageTrendingModel ;
  List images=[];
  List city=[];
  searchApi(String value) async {
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

  trendingHotel() async {
    var request = http.Request('GET', Uri.parse("${baseUrl1}hotel/trending")); http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var finalResponse = await response.stream.bytesToString();

      final finalResult = TrendingHotelModel.fromJson(json.decode(finalResponse));
      setState(() {
        imageTrendingModel= finalResult;

      });


    }
    else {
      print(response.reasonPhrase);
      print("api not run");
    }


  }

  getLocationApi() async {
    var request = http.Request('GET', Uri.parse('${baseUrl1}locations'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finaResult = jsonDecode(finalResponse);
      // print(await response.stream.bytesToString());
      for(Map i in finaResult['data']) {
        images.add(i["image"]);
        city.add(i["title"]);
      }
      setState(() {
      });

    }
    else {
      print(response.reasonPhrase);
    }


  }



  Widget _buildRooms(BuildContext context, int index) {
    var room = rooms[index % rooms.length];
    return Container(
      //height: 320,
      width: 300,
      margin: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // Image.network(images[index],height: 200,),
                  Container(
                    height: 200,


                    decoration: BoxDecoration(
                        color: Colors.black45.withOpacity(0.1),
                        image: DecorationImage(
                            image: NetworkImage(images[index]),fit:BoxFit.cover
                        )
                    ),
                  ),
                  // Positioned(
                  //   right: 10,
                  //   top: 10,
                  //   child: Icon(
                  //     Icons.star,
                  //     color: Colors.grey.shade800,
                  //     size: 20.0,
                  //   ),
                  // ),
                  Positioned(
                      left: 8,
                      top: 8,
                      child: Text(city[index],style: const TextStyle(color: Colors.white,fontSize: 20),)
                  ),
                  // Positioned(
                  //   bottom: 20.0,
                  //   right: 10.0,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(10.0),
                  //     color: Colors.white,
                  //     child: const Text("\$40"),
                  //   ),
                  // )
                ],
              ),
              // Container(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         room['title'],
              //         style: const TextStyle(
              //             fontSize: 18.0, fontWeight: FontWeight.bold),
              //       ),
              //       const SizedBox(
              //         height: 5.0,
              //       ),
              //       const Text("Bouddha, Kathmandu"),
              //       const SizedBox(
              //         height: 10.0,
              //       ),
              //       const Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Icon(
              //             Icons.star,
              //             color: Colors.green,
              //           ),
              //           Icon(
              //             Icons.star,
              //             color: Colors.green,
              //           ),
              //           Icon(
              //             Icons.star,
              //             color: Colors.green,
              //           ),
              //           Icon(
              //             Icons.star,
              //             color: Colors.green,
              //           ),
              //           Icon(
              //             Icons.star,
              //             color: Colors.green,
              //           ),
              //           SizedBox(
              //             width: 5.0,
              //           ),
              //           Text(
              //             "(220 reviews)",
              //             style: TextStyle(color: Colors.grey),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }





  Widget _buildRooms2(BuildContext context, int index) {
    var room = rooms[index % rooms.length];
    var item=imageTrendingModel?.data?[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(item?.image?? "" ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Icon(
                    Icons.star,
                    color: Colors.grey.shade800,
                    size: 20.0,
                  ),
                ),
                const Positioned(
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
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.white,
                    child:  Text("\u{20B9} ${item?.price?? "" }"),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item?.title?? "" ,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(item?.location?.name?? "" ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IgnorePointer(
                        ignoring: true,
                        child: RatingBar.builder(
                          initialRating: item?.reviewScore?.totalReview is int
                              ? (item?.reviewScore?.totalReview as int).toDouble()
                              : double.tryParse(item?.reviewScore?.totalReview?.toString() ?? "") ?? 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 12.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (_) {}, // Provide an empty function to disable editing
                        ),
                      )

                      // const Icon(
                      //   Icons.star,
                      //   color: Colors.green,size: 10,
                      // ),const Icon(
                      //   Icons.star,
                      //   color: Colors.green,size: 10,
                      // ),const Icon(
                      //   Icons.star,
                      //   color: Colors.green,size: 10,
                      // ),const Icon(
                      //   Icons.star,
                      //   color: Colors.green,size: 10,
                      // ),const Icon(
                      //   Icons.star,
                      //   color: Colors.green,size: 10,
                      // ),

                      ,SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Total Review ${item?.reviewScore?.totalReview?? ""} ' ,
                        style: const TextStyle(color: Colors.grey,fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
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
                            style: const TextStyle(
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
                            style: const TextStyle(
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
                    const Text('Adults'),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                peopleCount++;
                              });
                            },
                            child: const Icon(Icons.add_circle_outline)),
                        const SizedBox(
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
                            child: const Icon(Icons.remove_circle_outline)),
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
                    const Text('Child'),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                childCount++;
                              });
                            },
                            child: const Icon(Icons.add_circle_outline)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${childCount}'),
                        const SizedBox(
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
                            child: const Icon(Icons.remove_circle_outline)),
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
                        minimumSize: const Size(double.maxFinite, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Apply')),
                const SizedBox(
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


  String dayOfWeek= '';

  bool isCheckInSelected = false ;
  bool isCheckOutSelected = false ;


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
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(title, style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}

