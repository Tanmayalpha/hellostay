
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellostay/constants/colors.dart';
import 'package:hellostay/model/hotel_detail_response.dart';
import 'package:hellostay/repository/apiConstants.dart';
import 'package:hellostay/utils/gallery_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';


class HotelDetailsScreen extends StatefulWidget {
  const HotelDetailsScreen({
    Key? key,
    this.imageD,
    this.titleD,
    this.priceD,
    this.locationD,
    this.idD,
    this.latLang1D,
    this.latLang2D,
    this.ratingD,
  }) : super(key: key);

  final String? imageD, titleD, locationD, idD, latLang1D, latLang2D;
  final num? ratingD, priceD;

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  final Set<Marker> _markers = {};
  List<String>? photoD = [];
  List<String>? serviceD = [];
  List<String>? descriptionD = [];
  List<dynamic> rooms = [];

  String ? selectedRoomId ;
  String ? reviewPrice ;
  List <dynamic> list = [] ;

  HotelDetailsResponse? hotelDetailsResponse;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getHotelDetail(widget.idD ?? '');


    setState(() {});
  }

  inIt() async {
    await getHotelDetail(widget.idD ?? '');
   // serviceD = api.hotelDetailsResponse?.hotel?.fl;
    /*api.hotelDetailsResponse?.hotel?.img?.forEach((element) {
      photoD?.add(element.url ?? '');
    });*/

    //descriptionD?.add(api.hotelDetailsResponse?.hotel?.des ?? '');


  }




  @override
  Widget build(BuildContext context) {
    var _location = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 50.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            widget.locationD ?? '',
            style: const TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 190.0,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(widget.latLang1D ?? '22.7196'),
                        double.parse(widget.latLang2D ?? '75.8577')),
                    zoom: 13.0,
                  ),
                  markers: _markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 135.0, right: 60.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      /*Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => maps()));*/
                    },
                    child: Container(
                      height: 35.0,
                      width: 95.0,
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0))),
                      child: const Center(
                        child: Text('seeMap',
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Sofia")),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
    double height = MediaQuery.of(context).size.height;

    var roomes = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Text(
            'Rooms',
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 5.0),
        card(rooms),
        SizedBox(
          height: 25.0,
        ),
      ],
    );

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(
                expandedHeight: height - 30.0,
                img: hotelDetailsResponse?.data.image ?? '',
                id: hotelDetailsResponse?.data.id.toString() ?? '',
                title: hotelDetailsResponse?.data.title.toString() ?? '',
                price: double.parse(hotelDetailsResponse?.data.price ?? '150'),
                location: hotelDetailsResponse?.data.location?.name ?? '',
                ratting: double.parse(hotelDetailsResponse?.data.reviewScore?.scoreTotal ?? '4.5')),
            pinned: true,
          ),
          SliverToBoxAdapter(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                /*StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        } else {
                          var userDocument = snapshot.data;
                          _nama = userDocument["name"];
                          _email = userDocument["email"];
                          _photoProfile = userDocument["photoProfile"];
                        }

                        var userDocument = snapshot.data;
                        return Container();
                      },
                    ),*/

                /// Description
                const Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Text(
                    'details',
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
                      children: (descriptionD ?? [])
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10.0, bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: StyledText(
                                        text: item.replaceAll("<br>", "\n"),
                                        tags: {
                                          'b': StyledTextTag(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          'i': StyledTextTag(
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic))
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()),
                ),

                /// Location
                _location,

                /// service
                const Padding(
                  padding: EdgeInsets.only(
                      top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Text(
                    'amnesties',
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.justify,
                  ),
                ),

                //Text(_nama),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (serviceD ?? [])
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10.0, bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "-   ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 24.0),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child:  Text(
                                        item,
                                        style: const TextStyle(
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

                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'photos',
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  GalleryScreen(image: photoD ?? [])));
                        },
                        child: Text(
                          'seeAll',
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.black38,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 0.0, right: 0.0, bottom: 40.0),
                  child: SizedBox(
                    height: 150.0,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: (photoD ?? [])
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0, bottom: 10.0),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder:
                                                    (BuildContext context, _,
                                                        __) {
                                                  return  Material(
                                                    color: Colors.black54,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(30.0),
                                                      child: InkWell(
                                                        child: Hero(
                                                            tag:
                                                                "hero-grid-${widget.idD}",
                                                            child:
                                                                Image.network(
                                                              item,
                                                              width: 300.0,
                                                              height: 300.0,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                                transitionDuration: Duration(
                                                    milliseconds: 500)));
                                      },
                                      child: Container(
                                        height: 130.0,
                                        width: 130.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(item),
                                                fit: BoxFit.cover),
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2.0)
                                            ]),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
                  ),
                ),

                roomes,

                /*Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Cancellation Policy',
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const Icon(Icons.arrow_forward_outlined),
                        InkWell(
                          onTap: () {
                            *//* Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => questionSeeAll(
                                      title: widget.titleD,
                                      name: _nama,
                                      photoProfile: _photoProfile,
                                    )));*//*


                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black54,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                ),*/
                const SizedBox(
                  height: 0.0,
                ),
                // Question
                /* Column(
                      children: [
                        questionCard(
                        */ /*userId: widget.userId,
                        list: snapshot.data.docs*/ /*)
                      ],
                    ),*/

                // Review
                /*Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 0.0,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Reviews',
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        ReviewScreen()));
                              },
                              child: Text(
                                'seeAll',
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        ratingCard(
                          rattings: widget.ratingD.toString(),

                          *//*userId: widget.userId,
                            list: snapshot.data.docs*//*
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),*/

                /// Button
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 10.0),
                  child: InkWell(
                    onTap: () async {
                      /*Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new Room(
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
                                serviceD: widget.serviceD,
                                typeD: widget.typeD,
                                emailD: _email,
                                nameD: _nama,
                                photoProfileD: _photoProfile,
                              )));*/

                      if(selectedRoomId == null){
                        Fluttertoast.showToast(msg: 'Please Select a room');
                      }else {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomReview(
                                titleD: widget.titleD,
                                roomType: selectedRoomId,
                                locationD: widget.locationD,
                                ratingD: widget.ratingD,
                                priceR: reviewPrice ?? '',
                                list: list,
                                idD: widget.idD,


                              ),
                            ));*/
                      }
                    },
                    child: Container(
                      height: 55.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          gradient: LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.redAccent,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp)),
                      child: const Center(
                        child: Text(
                          'Review Now',
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
              ]))
        ],
      ),
    ));
  }


  Widget card (List<dynamic> rooms){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: false,
          itemCount: rooms.length,
          itemBuilder: (context, i) {
            //List<String> photo = List.from(list[i].data()['photo']);
            // List<String> service = List.from(list[i].data()['service']);
            // List<String> description = List.from(list[i].data()['description']);
            String title = rooms[i].ris?.first.rc ?? '';
            // String type = list[i].data()['type'].toString();
            double rating = 4.5;
            String des = rooms[i].ris?.first.des ?? '';
            // String image =
            //     'https://media-cdn.tripadvisor.com/media/photo-m/1280/21/dc/28/e0/fortune-pandiyan-hotel.jpg';
            num? price = rooms[i].ris?.first.tp ?? 150;
            bool isSelected = rooms[i].isSelected?? false;
            String roomId  = rooms[i].id ?? '';
            //String hotelId = hotelDetailsResponse?.hotel?.id ?? '' ;
            //num latLang1 = list[i].data()['latLang1'];
            // num latLang2 = list[i].data()['latLang2'];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 250,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            color: Colors.black87),
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.location_on,
                          size: 18.0,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            des,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 18.0,
                            color: Colors.yellow,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Sofia",
                                  fontSize: 13.0),
                            ),
                          ),
                          const SizedBox(
                            width: 35.0,
                          ),
                          Container(
                            height: 27.0,
                            width: 82.0,
                            decoration: const BoxDecoration(
                                color: Color(0xFF09314F),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                            child: Center(
                              child: Text("\$ " + price.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CancellationPolicyView(
                                    hotelId: hotelId,
                                    optionId: roomId,
                                  ),
                                ));*/
                          },
                          child: const Text('Cancellation Policy ',
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                fontSize: 12.0,
                                color: Colors.black87),),
                        ),

                        const SizedBox(width: 50,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              rooms.forEach((element) {
                                element.isSelected = false ;

                              });
                              rooms[i].isSelected = true;


                              selectedRoomId = rooms[i].id ?? '' ;


                              reviewPrice = rooms[i].ris?.first.tp.toString() ?? '';
                              list = rooms[i].ris ?? [] ;

                            });
                          },
                          child: Row(children: [
                            const Text('Select room',style: TextStyle(
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Colors.black87),),
                            const SizedBox(width: 8,),
                            Container(
                              padding: EdgeInsets.all(1),
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              child: Container(

                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent
                                ),
                              ),
                            ),
                          ],),
                        )

                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }


  getHotelDetail(String idD) async {
    
    
    apiBaseHelper.getAPICall(Uri.parse('${baseUrl1}hotel/detail/$idD')).then((getData) {


      String status = getData['status'].toString();

      if(status == '1'){

        hotelDetailsResponse = HotelDetailsResponse.fromJson(getData);

        hotelDetailsResponse?.data.gallery?.forEach((element) {
          photoD?.add(element ?? '');
        });
        descriptionD?.add(hotelDetailsResponse?.data.content ?? '');

        //rooms = hotelDetailsResponse?.hotel?.ops ?? [];
        rooms = [];

        _markers.add(Marker(
          markerId:
          MarkerId(hotelDetailsResponse!.data.mapLat !+ hotelDetailsResponse!.data.mapLng.toString()),
          position: LatLng(double.parse(hotelDetailsResponse!.data.mapLat ?? ''),
              double.parse(hotelDetailsResponse!.data.mapLng ?? '')),
          icon: BitmapDescriptor.defaultMarker,
        ));
        // serviceD = hotelDetailsResponse?.hotel?.fl;
        setState(() {

        });
      }else {

      }

      
    });
    











  }
  
  

}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, id, title, location;
  num price;
  num ratting;

  MySliverAppBar(
      {required this.expandedHeight,
      required this.img,
      required this.id,
      required this.title,
      required this.price,
      required this.location,
      required this.ratting});

  var _txtStyleTitle = TextStyle(
    color: Colors.black54,
    fontFamily: "Sofia",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Sofia",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/appLogo.png",
            height: (expandedHeight / 5) - (shrinkOffset / 40) + 24,
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-${id}',
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(img),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 620.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height/4.2,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.85)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                    width: 205.0,
                                    child: Text(
                                      title,
                                      style: _txtStyleTitle.copyWith(
                                          fontSize: 27.0),
                                      overflow: TextOverflow.clip,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "\$ " + price.toStringAsFixed(0),
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            color: Color(0xFF09314F),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Gotik"),
                                      ),
                                      Text('PER_NIGHT',
                                          style: _txtStyleSub.copyWith(
                                              fontSize: 11.0))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                        Icon(
                                          Icons.star_half,
                                          color: Color(0xFF09314F),
                                          size: 22.0,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 14.0,
                                            color: Colors.black26,
                                          ),
                                          Text(
                                            location,
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 14.5,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w400),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.white70,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class questionCard extends StatelessWidget {
  final String? userId;

  questionCard({this.list, this.userId});

  final List? list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: 1,
          itemBuilder: (context, i) {
            String pp = 'Photo Profile';
            String question = 'Detail question';
            String name = 'Name';
            String answer = 'Answer';
            String image = 'Image';
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: EdgeInsets.only(
                        left: 15.0, top: 0.0, bottom: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Color(0xFF09314F).withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        image == "null"
                            ? Container(height: 1, width: 1)
                            : Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Wrap(
                          children: [
                            Text(
                              'ask' + ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                            ),
                            Text(
                              question,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Wrap(
                          children: [
                            Text(
                              'answer' + ": ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                            ),
                            Text(
                              answer,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}

class ratingCard extends StatelessWidget {
  final String? rattings;

  ratingCard({this.list, this.rattings});

  final List? list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: 1,
          itemBuilder: (context, i) {
            String pp = 'Photo Profile';
            String review = 'Detail rating';
            String name = 'Name';
            String rating = rattings ?? '';
            return Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 22.0,
                              color: Colors.yellow,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                rating,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Sofia",
                                    fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              width: 35.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.only(
                          left: 15.0, top: 15.0, bottom: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        color: Color(0xFF09314F).withOpacity(0.1),
                      ),
                      child: Text(
                        review,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 17.5),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}



