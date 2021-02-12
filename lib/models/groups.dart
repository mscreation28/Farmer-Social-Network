class Group{
  final int groupId;
  final String groupName;
  final String groupDescription;

  Group({this.groupId, this.groupName,this.groupDescription});

  factory Group.fromJson(Map<String, dynamic> json){
    return Group(groupId: json['groupId'], groupName: json['groupName']);
  }

  Map<String,dynamic> toJson(){
    return {
      "groupId": groupId,
      "groupName": groupName,
      "groupDescription":groupDescription
    };
  }
}