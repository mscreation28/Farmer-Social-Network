class Group{
  final int groupId;
  final String groupName;

  Group({this.groupId, this.groupName,});

  factory Group.fromJson(Map<String, dynamic> json){
    return Group(groupId: json['groupId'], groupName: json['groupName']);
  }

  Map<String,dynamic> toJson(){
    return {
      "groupId": groupId,
      "groupName": groupName
    };
  }
}