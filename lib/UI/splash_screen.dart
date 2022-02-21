
import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_pharmecy_e_commerce/UI/login_screen.dart';
import 'package:hello_pharmecy_e_commerce/const/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Timer(Duration(seconds: 4), ()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>LoginScreen())));
    // TODO: implement initState
    super.initState();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_grey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Hello Pharmacy",
                style: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),

              SizedBox(height: 20.h,),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
