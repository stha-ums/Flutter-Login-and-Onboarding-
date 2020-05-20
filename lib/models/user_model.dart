// To parse this JSON data, do
//
//final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromServer(Map<String, dynamic> map) => UserData.fromJson(map);
Map<String, dynamic> userDataToServer(UserData data) => data.toJson();

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    String userId;
    String email;
    String userName;
    String imageUrl;   
    DateTime birthday; 
    bool isPaired;    
    String partnerUserId;
    String partnerImageUrl;
    String partnerName;
    DateTime partnerBirthday;
    DateTime anniversary;

    UserData({
      this.userId, 
      this.email, 
      this.userName,
      this.imageUrl,
      this.birthday,
      this.isPaired, 
      this.partnerUserId,  
      this.partnerImageUrl,
      this.partnerName,
      this.partnerBirthday,
      this.anniversary
    });
    /// Gets the instance of UserData for the default .
    static UserData get instance  => UserData();

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      userId: json["userId"], 
      email: json["email"], 
      userName: json["userName"],
      imageUrl: json["imageUrl"],
      birthday: json["birthday"],
      isPaired: json["isPaired"], 
      partnerUserId: json["partnerUserId"],  
      partnerImageUrl: json["partnerImageUrl"],
      partnerName: json["partnerName"],
      partnerBirthday: json["partnerBirthday"],
      anniversary: json["anniversary"],
    );
    update({
    String userId,
    String email,
    String userName,
    String imageUrl,   
    DateTime birthday, 
    bool isPaired,    
    String partnerUserId,
    String partnerImageUrl,
    String partnerName,
    DateTime partnerBirthday,
    DateTime anniversary,      
    }){
      this.userId= userId ; 
      this.email= email; 
      this.userName= userName;
      this.imageUrl= imageUrl;
      this.birthday= birthday;
      this.isPaired= isPaired; 
      this.partnerUserId=partnerUserId ;  
      this.partnerImageUrl= partnerImageUrl;
      this.partnerName=partnerName ;
      this.partnerBirthday=partnerBirthday ;
      this.anniversary= anniversary;
    }


    Map<String, dynamic> toJson() => {
      "userId": userId, 
      "email": email, 
      "userName": userName,
      "imageUrl": imageUrl,
      "birthday": birthday,
      "isPaired": isPaired, 
      "partnerUserId": partnerUserId,  
      "partnerImageUrl": partnerImageUrl,
      "partnerName": partnerName,
      "partnerBirthday": partnerBirthday,
      "anniversary": anniversary,
    };

  @override
  String toString() => 
  '''UserData{
      "userId": ${this.userId}, 
      "email": ${this.email}, 
      "userName": ${this.userName},
      "imageUrl": ${this.imageUrl},
      "birthday": ${this.birthday},
      "isPaired": ${this.isPaired}, 
      "partnerUserId": ${this.partnerUserId},  
      "partnerImageUrl": ${this.partnerImageUrl},
      "partnerName": ${this.partnerName},
      "partnerBirthday": ${this.partnerBirthday},
      "anniversary": ${this.anniversary},
  }''';

}
