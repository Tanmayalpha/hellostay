import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hellostay/model/hotel_pasanger_model.dart';
import 'package:http/http.dart' as http;

import 'book_now_view.dart';

class RoomReview extends StatefulWidget {
  String? imageD,
      titleD,
      locationD,
      idD,
      typeD,
      userId,
      nameD,
      photoProfileD,
      emailD,
      titleR,
      informationR,
      roomType,
      priceR,
      idR;

  List<String>? photoD, serviceD, descriptionD, imageR;
  num? ratingD, priceD, latLang1D, latLang2D;
 // List<RoomFullInfo>? list;
  List<dynamic>? list;

  RoomReview(
      {super.key,
      this.imageD,
      this.titleD,
      this.priceD,
      this.locationD,
      this.idD,
      this.photoD,
      this.serviceD,
      this.descriptionD,
      this.userId,
      this.typeD,
      this.emailD,
      this.nameD,
      this.photoProfileD,
      this.latLang1D,
      this.latLang2D,
      this.ratingD,
      this.idR,
      this.imageR,
      this.informationR,
      this.priceR,
      this.roomType,
      this.titleR,
      this.list});

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomReview> {
 // ReviewRoomResponse? reviewRoomResponse;
 dynamic reviewRoomResponse;
  //HotelBookingResponse? hotelBookingResponse;
  dynamic hotelBookingResponse;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState

    getRoomReview();
    super.initState();
  }

 // List<HotelPassengerModel> passenger = [];
  List<dynamic> passenger = [];

  @override
  Widget build(BuildContext context) {
    String _nama, _photoProfile, _email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.titleD ?? '',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Sofia",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*SizedBox(
                    height: 300.0,
                    child: Material(
                      child: Carousel(
                          dotSize: 0,
                          dotSpacing: 5,
                          dotColor: Colors.black26,
                          dotIncreaseSize: 1.7,
                          dotBgColor: Colors.transparent,
                          autoplay: true,
                          boxFit: BoxFit.cover,

                          images: List.generate(
                            reviewRoomResponse?.hInfo?.img?.length ?? 0,
                            (index) => Container(
                              height: 300,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(reviewRoomResponse
                                              ?.hInfo?.img?[index].url ??
                                          ''),
                                      fit: BoxFit.cover)),
                            ),

                          )),


                    ),


                  ),*/

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                    child: Text(
                      widget.list?.first.rc ?? '',
                      style: const TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 15.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.star,
                          size: 18.0,
                          color: Colors.yellow,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, left: 15.0),
                          child: Text(
                            reviewRoomResponse?.hInfo?.rt.toString() ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                                fontFamily: "Sofia",
                                fontSize: 19.0),
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      'information',
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (reviewRoomResponse?.hInfo?.fl ?? [])
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0, bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "-   ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.0),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black54,
                                              fontSize: 18.0),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      'location',
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 20.0, bottom: 20.0),
                    child: Text(
                      widget.locationD ?? '',
                      style: const TextStyle(
                          fontFamily: "Sofia",
                          color: Colors.black54,
                          fontSize: 18.0),
                    ),
                  ),

                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 20.0, left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'price',
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "\$" + '${reviewRoomResponse?.hInfo?.ops?.first.tp}',
                          style: const TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),

                  /// Button
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 10.0, top: 20.0),
                    child: InkWell(
                      onTap: () async {
                        for (int i = 0;
                            i <
                                int.parse(reviewRoomResponse
                                        ?.hInfo?.ops?.first.ris?.first.adt
                                        .toString() ??
                                    '0');
                            i++) {
                          passenger.add(HotelPassengerModel(
                            type: "ADULT ${i + 1}",
                          ));
                        }

                        /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>  Bookitnow(
                        userId: widget.userId,
                        titleD: widget.titleD,
                        idD: widget.idD,
                        imageD: widget.imageD,
                        latLang1D: widget.latLang1D,
                        latLang2D: widget.latLang2D,
                        locationD: widget.locationD,
                        priceD: widget.priceD,
                        descriptionD: widget.descriptionD,
                        photoD: widget.photoD,
                        ratingD: widget.ratingD,
                        listItem: widget.listItem,
                        serviceD: widget.serviceD,
                        typeD: widget.typeD,
                        emailD: _email,
                        nameD: _nama,
                        photoProfileD: _photoProfile,
                        idR: widget.idR,
                        imageR: widget.imageR,
                        informationR: widget.informationR,
                        priceR: widget.priceR,
                        roomType: widget.roomType,
                      )));*/
                        //bookHotel () ;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookNowView(
                                passengerList: passenger,
                                bookingId: reviewRoomResponse?.bookingId,
                                totalPayment: reviewRoomResponse
                                    ?.hInfo?.ops?.first.tp
                                    .toString(),
                              ),
                            )).then((value) {
                          passenger.clear();
                        });
                      },
                      child: Container(
                        height: 55.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF09314F),
                                  Color(0xFF09314F),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp)),
                        child: const Center(
                          child: Text(
                            'bookNow',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> getRoomReview() async {
    isLoading = true;
    setState(() {});
    var headers = {
      'Content-Type': 'application/json',
      'apikey': 'apiKey'
    };
    var request =
        http.Request('POST', Uri.parse('${'flightUrl'}hms/v1/hotel-review'));
    request.body =
        json.encode({"hotelId": widget.idD, "optionId": widget.roomType});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('${request.body}');
    print('${request.url}');

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      log('${finalResult}');
      /*final jsonResponse =
          ReviewRoomResponse.fromJson(json.decode(finalResult));*/

      setState(() {
       // reviewRoomResponse = jsonResponse;
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

}
