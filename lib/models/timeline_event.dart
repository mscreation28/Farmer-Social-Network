class TimelineEvent {
   int timelineId;
   int userCropId;
   String description;
   String title;
   DateTime timelineDate = new DateTime.now();

  TimelineEvent({
    this.description,
    this.timelineDate,
    this.timelineId,
    this.title,
    this.userCropId,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
        description: json['description'],
        timelineDate: DateTime.parse(json['timelineDate']),
        timelineId: json['timelineId'],
        title: json['title'],
        userCropId: json['userCropId']);
  }

  Map<String, dynamic> toJson(){
    return {
      "userCropId": userCropId,
      "description": description,
      "title": title,
      "timelineDate": timelineDate.toIso8601String(),
      "timelineId": timelineId
    };
  }
}
