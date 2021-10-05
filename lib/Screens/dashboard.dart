import 'package:deepika_assignment/Constants/constant.dart';
import 'package:deepika_assignment/CustomWidget/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:deepika_assignment/Utils/ListOfObjectsUtils.dart';
import 'package:deepika_assignment/Utils/app_utils.dart';
import 'package:deepika_assignment/Utils/enum_utils.dart';

import 'add_new_card_item.dart';
import 'listing_ui.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive {
    return true;
  }

  EnumDashboardActiveScreenType _activeScreen =
      EnumDashboardActiveScreenType.ALL;

  int _tabSelected = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  late Widget homePage;
  late Widget categoryA;
  late Widget categoryB;
  late Widget categoryC;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initBottomTabs();
    super.didChangeDependencies();
  }

  void _initBottomTabs() {
    homePage = ListingUI();
    categoryA = ListingUI(categoryObject: ListOfObjectsUtils.cardCategoryA);
    categoryB = ListingUI(categoryObject: ListOfObjectsUtils.cardCategoryB);
    categoryC = ListingUI(categoryObject: ListOfObjectsUtils.cardCategoryC);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Marvel Universe"),
            ),
            body: SafeArea(child: buildPageView()),
            bottomNavigationBar: _buildBottomAppBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black87,
              child: Icon(Icons.add, color: Colors.white,),
              // onPressed: ()=> Get.to(AddItemScreen())
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return AddItemScreen();
                }));
              },

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAppBar(){
    return BottomAppBar(
      child: Container(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: getNavigationButton('All', () {
                _changeScreenTo(EnumDashboardActiveScreenType.ALL);
              }, EnumDashboardActiveScreenType.ALL),
            ),
            Expanded(
              child: getNavigationButton('A', () {
                _changeScreenTo(EnumDashboardActiveScreenType.A);
              }, EnumDashboardActiveScreenType.A),
            ),
            Expanded(
              child: getNavigationButton('B', () {
                _changeScreenTo(
                    EnumDashboardActiveScreenType.B);
              }, EnumDashboardActiveScreenType.B),
            ),
            Expanded(
              child: getNavigationButton('C', () {
                _changeScreenTo(EnumDashboardActiveScreenType.C);
              }, EnumDashboardActiveScreenType.C),
            ),
          ],
        ),
      ),
    );
  }

  void selectedTab(int index) {
    if (_tabSelected == index) {
      _tabAlreadySelected(index);
    } else {
      _moveToTab(index);
    }
  }

  void _moveToTab(int index) {
    setState(() {
      _tabSelected = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 10), curve: Curves.ease);
    });
  }

  void _tabAlreadySelected(int index) {
    if (index == 0) {
    } else if (index == 1) {}
  }

  Widget buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      pageSnapping: false,
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[homePage, categoryA, categoryB, categoryC],
    );
  }

  void pageChanged(int index) {
    setState(() {
      _tabSelected = index;
    });
  }

  void _changeScreenTo(EnumDashboardActiveScreenType _changedScreen) {
    if (_changedScreen != _activeScreen) {
      _activeScreen = _changedScreen;
    }

    switch (_activeScreen) {
      case EnumDashboardActiveScreenType.ALL:
        selectedTab(0);
        break;
      case EnumDashboardActiveScreenType.A:
        selectedTab(1);
        break;
      case EnumDashboardActiveScreenType.B:
        selectedTab(2);
        break;
      case EnumDashboardActiveScreenType.C:
        selectedTab(3);
        break;
    }
    AppUtils.refreshCurrentState(this);
  }

  Widget getNavigationButton(
      String name,
      Function funToExecute,
      EnumDashboardActiveScreenType _screenType) {
    Color colorActive = Colors.white;
    Color colorInactive = Colors.grey;

    Color textSelectedColor =
    (_screenType == _activeScreen) ? colorActive : colorInactive;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(Constant.instance.appDefaultSpacingHalf / 2),
      child: InkWell(
        splashColor: Colors.grey[300],
        borderRadius: BorderRadius.circular(48.0),
        highlightColor: Colors.transparent,
        child: CustomWidget.getTextWidget(context, name, textAlign: TextAlign.center, fontWeight: FontWeight.w600,
        textColor: textSelectedColor),
        onTap: () {
          funToExecute();
        },
      ),
    );
  }
}
