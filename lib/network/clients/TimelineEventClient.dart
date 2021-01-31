import 'dart:convert';

import '../../models/timeline_event.dart';
import '../interfaces/ITimelineEventClient.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

class TimelineEventClient implements ITimeLineEventClient {
  static const String TIMELINE_URL = 'timeline';
  
  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  Future<http.Response> addTimelineEvent(TimelineEvent timelineEvent) async {
    String token = await getTokenString();
    var response = await http.post(
      '${Utils.BASE_URL}$TIMELINE_URL',
      headers: <String, String>{'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: jsonEncode(timelineEvent.toJson()),
    );
    print(jsonDecode(response.body));
    return response;
  }

  @override
  Future<http.Response> deleteTimelineEvent(int timelineId) async {
    String token = await getTokenString();
    var response =
        await http.delete('${Utils.BASE_URL}$TIMELINE_URL/$timelineId',headers: {
          'Authorization':'Bearer $token'
        });
    print(jsonDecode(response.body));

    return response;
  }

  @override
  Future<List<TimelineEvent>> getAllTimelineEvents(int userCropId) async {
    String token = await getTokenString();
    var response = await http.get('${Utils.BASE_URL}$TIMELINE_URL/$userCropId',headers: {
      'Authorization':'Bearer $token',
    });
    print(jsonDecode(response.body));
    List<TimelineEvent> timeLineEvents = [];
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var timeline in jsonResponse['timelines']) {
        timeLineEvents.add(new TimelineEvent.fromJson(timeline));
      }
    } else {
      throw Exception('Errro while fetching timeline');
    }
    return timeLineEvents;
  }

  @override
  Future<TimelineEvent> getSpecificTimelineEvent(int id) {
    // TODO: implement getSpecificTimelineEvent
    throw UnimplementedError();
  }

  @override
  Future<Response> updateTimelineEvent(TimelineEvent timelineEvent) async {
    String token = await getTokenString();
    var response = await http.patch(
      '${Utils.BASE_URL}$TIMELINE_URL/${timelineEvent.timelineId}',
      headers: <String, String>{'Content-type': 'application/json','Authorization':'Bearer $token'},
      body: jsonEncode(timelineEvent.toJson()),
    );
    print(jsonDecode(response.body));

    return response;
  }
}
