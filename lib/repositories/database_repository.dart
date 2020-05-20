import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wishwecouldtalk/models/user_model.dart';



class UserDataRepository{
  final Firestore _firestore;
  final UserData userData;

  UserDataRepository({
    Firestore firestore,
    UserData userData
    }):_firestore=firestore??Firestore.instance,
      userData=userData??UserData.instance;

  ///get the data of currenlty logged in user
  ///and save to local model UserData for easy data access
  Future<void> getUserData(String userID) async {
    //this gets the user data and if no data found than returns null
    var documentSnapshot = await _firestore
    .collection('UserData').document(userID).get();

    // print('${documentSnapshot.data != null}');

    if(documentSnapshot.data != null) { 
      var _newUserData = UserData.fromJson(documentSnapshot.data);
      userData.update(
       userId: _newUserData.userId , 
       email: _newUserData.email , 
       userName: _newUserData.userName ,
       imageUrl: _newUserData.imageUrl ,
       birthday: _newUserData.birthday ,
       isPaired: _newUserData.isPaired , 
       partnerUserId: _newUserData.partnerUserId ,  
       partnerImageUrl: _newUserData.partnerImageUrl ,
       partnerName: _newUserData.partnerName ,
       partnerBirthday: _newUserData.partnerBirthday ,
       anniversary: _newUserData.anniversary ,
      );
    
    }
  }

  Future <void> saveUserData() async{
    var data = userData.toJson();
    //convert the data to map and save to firestore
    await _firestore.collection('UserData').document(userData.userId).setData(data);
  }

  //check if the user is paired with anyone or not
  bool isPaired() {
    return this.userData.isPaired??false;
  }

  //this is called once the random code is generated
  Future<void> savePairingCode(int pairingCode) async {
    //TODO: add document path
    await _firestore.collection("PairingCode").document().setData(
      { 
        'UserId': pairingCode,
        'pairingCode': userData.userId
      }
    );
  }
  //this will call when user enters the pairing code
  Future<String> searchForPair(int pairingCode) async{
    var _pairingcode =  _firestore.collection('PairingCode');
    if(_pairingcode != null){
      await _pairingcode.where('pairingCode' ,isEqualTo: pairingCode)
      .getDocuments()
      .then((querySnapshot){
        var map = querySnapshot.documents[0].data;
        return map['UserId'];
      });
    }
    return null;
  }
  //this function after searchForPair is success
  Future<void> pair(String pairWithUserId) async{
    //for local 
    userData.update(
      partnerUserId: pairWithUserId,
      isPaired: true
    );

    // var map = userDataToServer(_userData);
    //for the one who entered the code of pair
    await _firestore.collection('UserData').document(userData.userId).updateData(
      {
        'partnerUserId':userData.partnerUserId,
        'isPaired':true,
      }      
    );

    //for that whose code was entered
    await _firestore.collection('UserData').document(userData.partnerUserId).updateData(
      {
        'partnerUserId':userData.userId,
        'isPaired':true,
      }
    );
    //TODO document path add
    await _firestore.collection('PairingCode').document().delete();
  }

  Future<void> checkForDataChange(){

  }

  Future<void> deleteAccountAndExit(){

  }
}