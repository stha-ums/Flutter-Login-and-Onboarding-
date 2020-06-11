import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:wishwecouldtalk/core/utilities/invitation_code_generator.dart';
import 'package:wishwecouldtalk/core/utilities/utils.dart';
import 'package:wishwecouldtalk/pairing/submit_button.dart';
import 'package:wishwecouldtalk/repositories/repositories.dart';
import 'package:wishwecouldtalk/style/dimentions.dart';

import '../injection_contatiner.dart' as di;

class PairingSceen extends StatefulWidget {
  @override
  _PairingSceenState createState() => _PairingSceenState();
}

class _PairingSceenState extends State<PairingSceen> {
  TextEditingController _textEditingController;
  FocusNode firstFocusNode;
  FocusNode secondFocusNode;
  FocusNode thirdFocusNode;
  FocusNode fourthFocusNode;
  FocusNode fifthFocusNode;
  FocusNode sixthFocusNode;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    fourthFocusNode = FocusNode();
    fifthFocusNode = FocusNode();
    sixthFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    // var code = InvitationCode().generate();
    getUserId();
    //save the pairing code with generating the random number
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.safeBlockWidth * 20,
            right: Dimensions.safeBlockWidth * 20),
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: Dimensions.safeAreaHeight / 20,
              child: Container(),
            ),
            Container(
              height: Dimensions.safeAreaHeight / 20,
              alignment: Alignment.center,
              child: Text(
                "Pairing",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: Dimensions.safeAreaHeight / 20,
              child: Container(),
            ),
            Container(
              height: Dimensions.safeAreaHeight / 20 * 2,
              child: SvgPicture.asset('assets/pairingScreen/invitation.svg'),
            ),
            Container(
              height: Dimensions.safeAreaHeight / 30,
              child: Container(),
            ),
            Container(
              height: Dimensions.safeAreaHeight / 20,
              alignment: Alignment.center,
              child: Text(
                "Please enter the pairing code of your partner or share your code to your partner",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: Dimensions.safeAreaHeight / 40,
              child: Container(),
            ),
            Container(
              alignment: Alignment.center,
              height: Dimensions.safeAreaHeight / 50,
              child: Text(
                'Your code',
              ),
            ),
            SizedBox(height: Dimensions.safeAreaHeight / 60),
            invitationCodeDisplayRow(),
            SizedBox(height: Dimensions.safeAreaHeight / 40),
            Container(
              alignment: Alignment.center,
              height: Dimensions.safeAreaHeight / 50,
              child: Text(
                'Enter partners code',
              ),
            ),
            SizedBox(height: Dimensions.safeAreaHeight / 60),
            invitationEnter(),
            SizedBox(height: Dimensions.safeAreaHeight / 40),
            SubmitInvitationCodeButton(),
          ],
        ),
      ),
    );
  }

  Row invitationEnter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          child: Container(
            height: 30,
            width: 30,
            child: TextField(
              focusNode: firstFocusNode,
              decoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: false,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              autofocus: true,
              style: TextStyle(fontSize: 30),
              // scrollPadding: EdgeInsets.all(0),
              showCursor: false,
              //this prevents from inserting random text from clipboard
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: true,
                paste: false,
                selectAll: false,
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {},
              onChanged: (value) {
                    if(Validators.hasOnlyNumbers(value)){
                      FocusScope.of(context).requestFocus(secondFocusNode);
                      print('yes');
                    }
              },
            ),
          ),
        ),
        Card(
          child: Container(
            height: 30,
            width: 30,
            child: TextField(
              focusNode: secondFocusNode,
              decoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: false,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              
              style: TextStyle(fontSize: 30),
              // scrollPadding: EdgeInsets.all(0),
              showCursor: false,
              //this prevents from inserting random text from clipboard
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: true,
                paste: false,
                selectAll: false,
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {},
              onChanged: (value) {
                    if(Validators.hasOnlyNumbers(value)){
                      FocusScope.of(context).requestFocus(thirdFocusNode);
                    }
                    if(value == ''){
                  FocusScope.of(context).requestFocus(firstFocusNode);
                }
              },
            ),
          ),
        ),
        Card(
          child: Container(
            height: 30,
            width: 30,
            child: TextField(
              focusNode: thirdFocusNode,
              decoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: false,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              
              style: TextStyle(fontSize: 30),
              // scrollPadding: EdgeInsets.all(0),
              showCursor: false,
              //this prevents from inserting random text from clipboard
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: true,
                paste: false,
                selectAll: false,
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {},
              onChanged: (value) {
                    if(Validators.hasOnlyNumbers(value)){
                      FocusScope.of(context).requestFocus(fourthFocusNode);
                    }
                    if(value == ''){
                  FocusScope.of(context).requestFocus(secondFocusNode);
                }
              },
            ),
          ),
        ),
        Card(
          child: Container(
            height: 30,
            width: 30,
            child: TextField(
              focusNode: fourthFocusNode,
              decoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: false,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              
              style: TextStyle(fontSize: 30),
              // scrollPadding: EdgeInsets.all(0),
              showCursor: false,
              //this prevents from inserting random text from clipboard
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: true,
                paste: false,
                selectAll: false,
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {},
              onChanged: (value) {
                    if(Validators.hasOnlyNumbers(value)){
                      FocusScope.of(context).requestFocus(fifthFocusNode);
                    }
                    if(value == ''){
                  FocusScope.of(context).requestFocus(thirdFocusNode);
                }
              },
            ),
          ),
        ),
        Card(
          child: Container(
            height: 30,
            width: 30,
            child: TextField(
              focusNode: fifthFocusNode,
              decoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: false,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              
              style: TextStyle(fontSize: 30),
              // scrollPadding: EdgeInsets.all(0),
              showCursor: false,
              //this prevents from inserting random text from clipboard
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: true,
                paste: false,
                selectAll: false,
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {},
              onChanged: (value) {
                    if(Validators.hasOnlyNumbers(value)){
                      FocusScope.of(context).requestFocus(sixthFocusNode);
                    }
                    if(value == ''){
                  FocusScope.of(context).requestFocus(fourthFocusNode);
                }
              },
            ),
          ),
        ),
        Card(
          child: Container(
            height: 30,
            width: 30,
            child: TextField(
              focusNode: sixthFocusNode,
              decoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: false,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              
              style: TextStyle(fontSize: 30),
              // scrollPadding: EdgeInsets.all(0),
              showCursor: false,
              //this prevents from inserting random text from clipboard
              toolbarOptions: ToolbarOptions(
                cut: false,
                copy: true,
                paste: false,
                selectAll: false,
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {},
              onChanged: (value) {
                if(value == ''){
                  FocusScope.of(context).requestFocus(fifthFocusNode);
                }
                    print('Time to submit baby');
              },
            ),
          ),
        ),
      ],
    );
  }

  Row invitationCodeDisplayRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: invitationCodeyour(),
    );
  }

  List<int> someList = [
    1,
    2,
    3,
    4,
    5,
    6
  ]; //this will be the random genereated number
  List<Widget> invitationCodeyour() {
    return new List<Widget>.generate(someList.length, (int index) {
      return Card(
        child: Container(
          // height: Dimensions.safeAreaHeight /30,
          width: 30,
          child: Text(
            '${someList[index]}',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    firstFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    fourthFocusNode.dispose();
    fifthFocusNode.dispose();
    sixthFocusNode.dispose();
    super.dispose();
  }

  String getUserId() {
    String data;
    di.sl<UserRepository>().getUserID().then((value) => data = value);
    return data;
  }
}
