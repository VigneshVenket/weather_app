import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/news/news_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';
import '../../model/repository/news_repo.dart';
import '../../model/repository/weather_repo.dart';
import '../base/custom_button.dart';
import '../base/custom_messenger.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';
import 'home_screen.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController locationController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResource.app_main_bg_color,

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  width:mediaQueryData.width*0.7,
                  height: mediaQueryData.height*0.15,
                  child: Image.asset(AppImages.applogo,fit: BoxFit.contain,)),
            ),
            SizedBox(height: mediaQueryData.height*0.03,),
            Text("Enter the City *",style: text_input_style.copyWith(color: ColorResource.text_content_color),),
            SizedBox(height: mediaQueryData.height*0.01,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: mediaQueryData.width*0.96,
                height: mediaQueryData.height*0.058,
                child: TextFormField(
                  controller: locationController,
                  cursorColor: ColorResource.app_theme_opac_color,

                  style: text_input_style.copyWith(color: ColorResource.title_color),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: ColorResource.app_theme_opac_color,
                      suffixIcon: Icon(
                        Icons.location_on,
                        size: 24,
                        color: ColorResource.title_color,
                      )
                  ),

                ),
              ),
            ),
            SizedBox(height: mediaQueryData.height*0.04,),
            Center(
              child: CustomButton(width: mediaQueryData.width*0.8,
                  height: mediaQueryData.height*0.07, title: "Start",
                  onTapped: (){

                     if(locationController.text.isNotEmpty){
                       CustomNavigation.push(context, MultiBlocProvider(
                           providers: [
                             BlocProvider(
                               create: (context) => WeatherBloc(
                                 weatherRepo:WeatherRepo(),
                               )..add(FetchWeather(locationController.text)),
                             ),
                             BlocProvider(
                               create: (context) => NewsBloc(
                                   newsRepo: NewsRepo()
                               ),
                             ),
                           ],
                           child: HomeScreen()));
                       // locationController.clear();
                     }else{
                        CustomMessenger.showMessage(context, "Location field should not be empty", Colors.red);
                     }
                  },
              ),
            )
          ],
        ),
      ),
    );
  }
}
