import 'package:flutter/material.dart';

import '../../bloc/news/news_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';
import '../../model/repository/news_repo.dart';
import '../../model/repository/weather_repo.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';
import '../utils/user_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';



class SettingsScreen extends StatefulWidget {
  final String city;

  const SettingsScreen({required this.city,super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.app_main_bg_color,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings',style: title_style.copyWith(color: ColorResource.title_color)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            CustomNavigation.pushReplacement(context, MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => WeatherBloc(
                      weatherRepo:WeatherRepo(),
                    )..add(FetchWeather(widget.city)),
                  ),
                  BlocProvider(
                    create: (context) => NewsBloc(
                        newsRepo: NewsRepo()
                    ),
                  ),
                ],
                child: HomeScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResource.app_bg_color
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Temperature Unit",style: splash_content.copyWith(color: ColorResource.text_content_color),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.025,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomRadioContainer("C", "Celsius"),
              ),
               SizedBox(height: MediaQuery.of(context).size.height*0.02,),
               Padding(
                 padding: const EdgeInsets.only(left: 10.0),
                 child: CustomRadioContainer("F","Fahernheit"),
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomRadioContainer(String tempunit,String title){
    return GestureDetector(
      onTap: (){
        setState(() {
          UserPreferences.setTemperatureUnit(tempunit);
        });

      },
      child: Row(
        children: [
          UserPreferences.temperatureUnit==tempunit?
          Icon(Icons.radio_button_checked_outlined,color: ColorResource.app_theme_color,):
          Icon(Icons.radio_button_off_outlined,color: ColorResource.title_color,),
          SizedBox(width: MediaQuery.of(context).size.width*0.05,),
          Text(title,style: text_input_style,)
        ],
      ),
    );
  }

}


