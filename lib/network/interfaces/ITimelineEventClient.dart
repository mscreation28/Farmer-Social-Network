import 'package:KrishiMitr/models/timeline_event.dart';

abstract class ITimeLineEventClient{
  Future<List<TimelineEvent>> getAllTimelineEvents(int userCropId);
  Future<TimelineEvent> getSpecificTimelineEvent(int id);
  void deleteTimelineEvent(int id);
  void updateTimelineEvent(TimelineEvent timelineEvent);
  void addTimelineEvent(TimelineEvent timelineEvent);
}