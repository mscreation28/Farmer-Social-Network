import 'dart:convert';

import 'package:KrishiMitr/models/timeline_event.dart';
import 'package:KrishiMitr/network/interfaces/ITimelineEventClient.dart';
import 'package:http/http.dart' as http;

import 'Utils.dart';

class TimelineEventClient implements ITimeLineEventClient {
  static const String TIMELINE_URL = 'timeline';

  @override
  void addTimelineEvent(TimelineEvent timelineEvent) async {
    var response = await http.post(
      '${Utils.BASE_URL}$TIMELINE_URL',
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(timelineEvent.toJson()),
    );
    print(jsonDecode(response.body));
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
    } else {
      throw Exception('Error while adding timeline');
    }
  }

  @override
  void deleteTimelineEvent(int timelineId) async {
    var response =
        await http.delete('${Utils.BASE_URL}$TIMELINE_URL/$timelineId');
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception('Error while deleting timeline');
    }
  }

  @override
  Future<List<TimelineEvent>> getAllTimelineEvents(int userCropId) async {
    var response = await http.get('${Utils.BASE_URL}$TIMELINE_URL/$userCropId');
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
  void updateTimelineEvent(TimelineEvent timelineEvent) async {
    var response = await http.patch(
      '${Utils.BASE_URL}$TIMELINE_URL/${timelineEvent.timelineId}',
      headers: <String, String>{'Content-type': 'application/json'},
      body: jsonEncode(timelineEvent.toJson()),
    );
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception('Error while deleting timeline');
    }
  }
}
