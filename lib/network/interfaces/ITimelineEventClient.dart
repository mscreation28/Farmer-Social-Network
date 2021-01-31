import '../../models/timeline_event.dart';
import 'package:http/http.dart';

abstract class ITimeLineEventClient{
  Future<List<TimelineEvent>> getAllTimelineEvents(int userCropId);
  Future<TimelineEvent> getSpecificTimelineEvent(int id);
  Future<Response> deleteTimelineEvent(int id);
  Future<Response> updateTimelineEvent(TimelineEvent timelineEvent);
  Future<Response> addTimelineEvent(TimelineEvent timelineEvent);
}