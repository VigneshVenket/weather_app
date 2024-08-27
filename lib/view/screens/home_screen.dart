import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/view/screens/settings_screen.dart';
import '../../bloc/news/news_bloc.dart';
import '../../bloc/news/news_event.dart';
import '../../bloc/news/news_state.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_state.dart';
import '../../model/data_models/news.dart';
import '../../model/data_models/weather.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';
import '../utils/user_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Weather? weather;
  bool isFiterTapped=false;
  String? city;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResource.app_main_bg_color,
      appBar: AppBar(
        title:  Text("Home",
          style: title_style.copyWith(color: ColorResource.title_color),),
        backgroundColor: ColorResource.app_bg_color,
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings,color: ColorResource.title_color,size: 26,),
            onPressed: () {
              CustomNavigation.pushReplacement(context,SettingsScreen(city: city!,));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return Text('Enter a city to get the weather');
                  } else if (state is WeatherLoading) {
                    return  const Center(
                      child: CircularProgressIndicator(
                        color: ColorResource.app_theme_color,
                      ),
                    );
                  } else if (state is WeatherLoaded) {
                     weather = state.weather;
                     city=weather!.name;

                    BlocProvider.of<NewsBloc>(context).add(FetchNews());
                    return _buildWeather(weather!);
                  } else if (state is WeatherError) {
                    return Center(
                      child: Text("Please Go back and enter valid City Name",
                        textAlign: TextAlign.center,
                        style:
                      title_style.copyWith(color:ColorResource.title_color
                      ),),
                    );
                  }
                  return Container();
                },
              ),

              SizedBox(height: mediaQueryData.height*0.02,),
              BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                if (state is NewsLoading) {
                    return  const Center(
                      child: CircularProgressIndicator(
                        color: ColorResource.app_theme_color,
                      ),
                    );
                  } else if (state is NewsLoaded) {
                    final category = _getCategoryForWeather(weather!);
                    final filteredNews = filterNewsByCategory(state.news, category);
                    // return _buildNewsList(filteredNews);
                    return isFiterTapped?_buildNewsList(filteredNews,"Based on current weather"):_buildNewsList(state.news,"All");
                  } else if (state is NewsError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeather(Weather weather) {
    final mediaQueryData=MediaQuery.of(context).size;
    final tempUnit = UserPreferences.temperatureUnit;
    final displayTemperature = tempUnit == 'F'
        ? (weather.temperature! * 9 / 5) + 32
        : weather.temperature;
    final displayMax = tempUnit == 'F'
        ? (weather.max! * 9 / 5) + 32
        : weather.max;

    final displayMin = tempUnit == 'F'
        ? (weather.min! * 9 / 5) + 32
        : weather.min;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: mediaQueryData.width*0.95,
          height: mediaQueryData.height*0.33,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResource.app_bg_color
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: mediaQueryData.width*0.5,
                  height: mediaQueryData.height*0.18,
                  child: Image.asset(AppImages.applogo),
                ),
              ),
              Center(child: Text("${displayTemperature!.toStringAsFixed(2)}°$tempUnit",style: temp_style,)),
              Center(child: Text("${weather.name}",style: title_style.copyWith(color: ColorResource.text_content_color),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Max : ${displayMax!.toStringAsFixed(2)}°$tempUnit",style: user_name.copyWith(color: ColorResource.text_content_color),),
                  SizedBox(width: mediaQueryData.width*0.05,),
                  Text("Min : ${displayMin!.toStringAsFixed(2)}°$tempUnit",style: user_name.copyWith(color: ColorResource.text_content_color),)
                ],
              )
            ],
          ),
        )


        // Add more weather details and forecast here
      ],
    );
  }

  Widget _buildNewsList(List<News> news,String title) {
    final mediaQueryData=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("News Headlines",style: title_style.copyWith(color: ColorResource.title_color),),
            GestureDetector(
                onTap: (){
                  setState(() {
                    isFiterTapped=!isFiterTapped;
                  });
                },
                child: Icon(Icons.tune,size: 24))
          ],
        ),
        SizedBox(height: mediaQueryData.height*0.02,),
        news.isNotEmpty?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: splash_content.copyWith(color: ColorResource.text_content_color),),
            SizedBox(height: mediaQueryData.height*0.01,),
            Container(
              width: mediaQueryData.width*0.95,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final article = news[index];
                  return Column(
                    children: [
                      Container(
                        width: mediaQueryData.width*0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorResource.app_bg_color
                        ),
                        child: ListTile(
                          leading: Container(
                            width: mediaQueryData.width*0.15,
                            height: mediaQueryData.height*0.03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image.asset(AppImages.newsHeadlineImage,fit: BoxFit.fill,),
                          ),
                          title: Text(article.title!,style: text_input_style.copyWith(color: ColorResource.title_color),),
                          onTap: (){
                            _launchURL(article.url!);
                          },
                        ),
                      ),
                      SizedBox(height: mediaQueryData.height*0.01,)
                    ],
                  );
                },
              ),
            ),
          ],
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: splash_content.copyWith(color: ColorResource.text_content_color),),
           SizedBox(height: mediaQueryData.height*0.01,),
            Container(
              width: mediaQueryData.width*0.95,
              height: mediaQueryData.height*0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResource.app_bg_color
              ),
              child: Center(
                child: Text(
                  "No News Found based on current weather",
                  textAlign: TextAlign.center,
                  style: text_input_style.copyWith(color: ColorResource.text_content_color),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    // print('Trying to launch $url');
    bool canLaunch = await canLaunchUrl(uri);
    // print('Can launch: $canLaunch');
    if (canLaunch) {
      // print('Launching $url');
      await launchUrl(uri);
    } else {
      // print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  String _getCategoryForWeather(Weather weather) {
    if (weather.temperature! < 10) {
      return 'depressing';
    } else if (weather.temperature! > 30) {
      return 'fear';
    } else {
      return 'happiness';
    }
  }


  List<News> filterNewsByCategory(List<News> articles, String category) {
    List<News> filteredArticles = [];
    List<String> keywords;

    switch (category) {
      case 'depressing':
        keywords = ['tragedy', 'disaster', 'loss'];
        break;
      case 'fear':
        keywords = ['danger', 'threat', 'crisis'];
        break;
      case 'happiness':
        keywords = ['success', 'joy', 'victory'];
        break;
      default:
        keywords = [];
    }

    for (var article in articles) {
      if (keywords.any((keyword) => article.title!.toLowerCase().contains(keyword))) {
        filteredArticles.add(article);
      }
    }

    return filteredArticles;
  }

}
