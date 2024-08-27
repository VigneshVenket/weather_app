
class Weather {

   double? temperature;
   String? condition;
   String? name;
   double? max;
   double? min;
   double? lat;
   double? long;

  Weather({
    required this.temperature,
    required this.condition,
    required this.name,
    required this.max,
    required this.min,
    required this.lat,
    required this.long
  });

  Weather.fromJson(Map<String, dynamic> json) {
    temperature= json['main']['temp'];
    min= json['main']['temp_min'];
    max= json['main']['temp_max'];
    name=json['name'];
    condition= json['weather'][0]['description'];
    lat=json['coord']['lat'];
    long=json['coord']['lon'];
  }
}
