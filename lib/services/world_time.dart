import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoints
  bool isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      //make the request
      var Url = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      Response response = await get(Url);
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset) ));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      this.time = DateFormat.jm().format(now);
      //this.time = now.toString();
    }
    catch(e){
      print('caught error: $e');
      this.time = 'could not get time data';
    }

    //var Url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    //Response response = await get(Url);


  }


}
