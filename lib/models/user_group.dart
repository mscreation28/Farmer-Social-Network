class UserGroup {
  int userGroupId;
  int userId;
  int groupId;  

  UserGroup({
    this.userGroupId,    
    this.groupId,
    this.userId,    
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
        userGroupId: json['userGroupId'],        
        groupId: json['groupId'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userGroupId": userGroupId,      
      "userId": userId,
      "groupId": groupId,      
    };
  }
}
