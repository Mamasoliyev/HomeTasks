// ignore_for_file: unnecessary_this

extension StringExtension on String{
  String toWeatherCondition(){
    if (this.toLowerCase().contains('cloud')){
      return 'cloudy';
    }else if (this.toLowerCase().contains('rain')){
      return 'rain';
    }else if (this.toLowerCase().contains('sun')){
      return 'sunny';
    }else if (this.toLowerCase().contains('snow')){
      return 'snow';
    }
    else{
      return 'snow';
    }
  }
}