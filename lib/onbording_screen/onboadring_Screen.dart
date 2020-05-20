import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/onboarding/onbording_message.dart';
import '../repositories/repositories.dart';
import '../style/dimentions.dart';
import 'bloc/onboarding.dart';
import 'create_account_button.dart';
import 'signinButton.dart'; 

class OnboardingScreen extends StatefulWidget {
  final UserRepository _userRepository;
  const OnboardingScreen({Key key, userRepository}) 
    :_userRepository =userRepository, 
    assert (userRepository != null), super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin{
  TabController _tabController;
  OnboardingBloc _onboardingBloc;
  
  UserRepository get _userRepository => widget._userRepository;

  @override 
  void initState() {
    _onboardingBloc = OnboardingBloc();
    _tabController =TabController(
      length: onboardingData.length,
      vsync: this
    );
    _tabController.addListener(() {
      _onboardingBloc.add(ScrolledTabView(_tabController.index));
     });
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);

    return Scaffold(
      body: BlocProvider<OnboardingBloc>(
        create:(context) => _onboardingBloc ,
        child: onBoardingScreen(),
       ),
    );
  }
  Widget onBoardingScreen(){
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
              Expanded(
                child: Container(
                  color: Color(0xffFEFAF9),
                  child: Column(
                    children: [
                      Expanded(child: 
                      TabBarView(        
                        controller: _tabController,
                        children:_onboradingTabList(),
                      ),
                    ),
                    SizedBox(height: Dimensions.blockHeight*3,),
                    BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, state) {
                        return _indicatorTab(selecteTabindex:state.selectedIndex);
                      }
                    ),
                    SizedBox(height: Dimensions.blockHeight*2,)
                    ],
                  ),
                ),
            ),
            SizedBox(height: Dimensions.blockHeight*5,), 
            Padding(
              padding: EdgeInsets.only(left:Dimensions.safeBlockWidth*20,top: Dimensions.safeBlockWidth*10,right: Dimensions.safeBlockWidth*20),
              child: SignInButton(userRepository :_userRepository),
            ),
            SizedBox(height: Dimensions.safeBlockHeight*3,),
            Padding(
              padding: EdgeInsets.only(left:Dimensions.safeBlockWidth*20,bottom: Dimensions.safeBlockWidth*20,right: Dimensions.safeBlockWidth*20),
              child: CreateAccountButton(userRepository :_userRepository),
            ),
          ],
        );
  }

  List<Widget> _onboradingTabList(){
    return  List <Widget>.generate(onboardingData.length, (index) => _onboradingTab(onboardingData[index]));
  }

  Widget _onboradingTab(Map<String, dynamic> data){
       return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(data['imageUrl'],
            height: Dimensions.safeBlockHeight*80,
            width: Dimensions.safeBlockWidth*140,
            colorBlendMode: BlendMode.darken,
            ),
            SizedBox(height: Dimensions.safeBlockHeight*5,),
            Padding(
              padding: EdgeInsets.only(left:Dimensions.safeBlockHeight*8,right: Dimensions.safeBlockHeight*8),
              child: Text(data['title'],
              style: TextStyle(
                fontSize: Dimensions.blockWidth*12,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,),
            ),
            SizedBox(height: Dimensions.blockWidth*9,),
            Padding(
              padding:  EdgeInsets.only(left:Dimensions.safeBlockHeight*10,right: Dimensions.safeBlockHeight*10),
              child: Text(data['message'],
              style: TextStyle(
                fontSize: Dimensions.blockWidth*9,
              ),
              textAlign: TextAlign.center,),
            ),
            SizedBox(height: Dimensions.safeBlockHeight*4,),
            
          ],
        );
  }


Widget _indicatorTab({int selecteTabindex} ){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: _indicatorTabList(selecteTabindex:selecteTabindex),

    );
}
List <Widget>_indicatorTabList ({int selecteTabindex}){
  return new List<Widget>.generate(onboardingData.length, 
  (index) => Row(children: [
    Tab(
        icon: Icon(FontAwesomeIcons.solidCircle,
        size: Dimensions.blockWidth*5,
        color: index==selecteTabindex?Colors.red:Colors.red[200],
        )
      ),
      SizedBox(width: Dimensions.blockWidth*3,),
  ]));
}

}



