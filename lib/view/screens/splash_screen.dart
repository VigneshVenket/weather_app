import 'dart:async';

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';
import 'location_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    // TODO: implement initState
    navigateToLoginScreen();
    super.initState();
  }


  void navigateToLoginScreen(){
    Timer(Duration(seconds: 3),(){
      CustomNavigation.pushReplacement(context, LocationScreen());
    });
  }


  @override
  Widget build(BuildContext context) {
    final _mediaQueryData=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResource.app_bg_color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                width:_mediaQueryData.width*0.8,
                height: _mediaQueryData.height*0.15,
                child: Image.asset(AppImages.applogo,fit: BoxFit.contain,)),
          ),

          Container(
            width:_mediaQueryData.width*0.57,
            height: _mediaQueryData.height*0.15,
            child: Text("Get real-time weather and news updates",
              textAlign: TextAlign.center,
              style: splash_content.copyWith(color: ColorResource.title_color),),
          )
        ],
      ),
    );
  }



}
