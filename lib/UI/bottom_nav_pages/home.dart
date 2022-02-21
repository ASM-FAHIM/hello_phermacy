import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_pharmecy_e_commerce/const/appcolors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  List<String> _carouselImages = [];
  var _dotPosition = 0;
  TextEditingController _searchController = TextEditingController();

  Future <List<String>> fetchCarouselImages() async{
    var _firebaseInstance = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _firebaseInstance.collection("carousel-slider").get();

    setState(() {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        _carouselImages.add(
          querySnapshot.docs[i]["img-path"],
        );
        print(querySnapshot.docs[i]["img-path"]);
      }
    });

   return _carouselImages;
  }

  @override
  void initState() {
    fetchCarouselImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                children: [
                  Expanded(child: SizedBox(
                    height: 60.h,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.5)),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          )
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2.5)),
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
                            )
                        ),
                        hintText: "Search products here",
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey,
                        )
                      ),
                    ),
                  )),
                  GestureDetector(
                    child: Container(
                      height: 60.h,
                      width: 60.h,
                      color: AppColors.deep_grey,
                      child: const Center(
                        child: Icon(Icons.search_rounded, color: Colors.white,),
                      ),
                    ),
                    onTap: (){

                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                  items: imgList
                      .map((item) => Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.fitWidth)),
                    ),
                  ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            SizedBox(height: 10.h,),
            DotsIndicator(dotsCount: imgList.isEmpty ? 1: imgList.length,
            position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.deep_grey,
                color: AppColors.deep_grey.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6,6),
              ),
            ),
          ],
        )
      )),
    );
  }
}
