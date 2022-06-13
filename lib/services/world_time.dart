import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String? location ;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getData()async{
    try{
      Response respons= await get(Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));
      Map data1=jsonDecode(respons.body);

      String dt=data1['datetime'];
      String offset=data1['utc_offset'].substring(1,3);

      DateTime now =DateTime.parse(dt);
      now=now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20? true:false;
      time=DateFormat.jm().format(now);
    }catch(e){
      print('caught error: $e');
      time='could not get time data';
    }


  }
}