class WeatherModels{
  final String Cityname;
  final double tempture;
  final String maincondition;
  WeatherModels({
    required this.Cityname,
    required this.maincondition,
    required this.tempture,
});
  factory WeatherModels.fromjson(Map<String,dynamic> json){
    return WeatherModels(
        Cityname: json['name'],
        maincondition: json['weather'][0]['main'],
        tempture: json['main']['temp']);
  }
}