import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:deepika_assignment/Constants/constant.dart';
import 'package:deepika_assignment/CustomWidget/custom_widgets.dart';
import '../Model/card_category_object.dart';
import '../GetX/card_controller.dart';
import '../Model/card_object.dart';

class ListingUI extends StatefulWidget {

  final CardCategoryObject? categoryObject;

  ListingUI({this.categoryObject});

  @override
  _ListingUIState createState() => _ListingUIState(categoryObject: categoryObject);
}


class _ListingUIState extends State<ListingUI>{

  final CardCategoryObject? categoryObject;

  _ListingUIState({this.categoryObject});

  final _controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  _buildMainWidget(),
    );
  }


  Widget _buildMainWidget() {

    return Column(
      children: [
        GetBuilder<CardController>(
          builder: (_) => Container(
            padding: EdgeInsets.all(Constant.instance.appDefaultSpacingHalf),
            child: Text(
                '${_controller.getCount().toString()} Cards Showing'
            ),
          ),
        ),
        Expanded(
          child: NotificationListener(

            child: GetBuilder<CardController>(
                builder: (_) => _getListViewOfCardItems()
            ),
            onNotification: (ScrollNotification scrollInfo) {
              double currentPixel = scrollInfo.metrics.pixels;

              if (currentPixel == scrollInfo.metrics.maxScrollExtent) {
                _controller.hitApiAndGetCardData();
              }
              /*if (scrollInfo is ScrollEndNotification) {
                _controller.hitApiAndGetCardData();
              }*/
              return true;
            },
          )
        ),
      ],
    );
  }

  int _getCardFilterID() => categoryObject?.id ?? -1;

  Widget _getListViewOfCardItems() {
    return ListView.builder(
      itemCount: _controller.getCount(),
        itemBuilder: (BuildContext context, int index){
          var _cardItem = _controller.listOfCards![index];
          if(categoryObject == null) {
            return _buildCardView(_cardItem);
          } else {
            if (_cardItem.cardCategoryObject?.id == _getCardFilterID()) {
              return _buildCardView(_cardItem);
            } else {
              return Container();
            }
          }
        }
    );
  }


  Widget _buildCardView(CardObject cardObject){
    return Container(
      child: Card(
        elevation: 4.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Image.asset(cardObject.images ?? "", fit: BoxFit.contain,),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomWidget.getTextWidget(context, '${cardObject.name}', fontWeight: FontWeight.bold
                        ),
                          flex: 2,),
                        Expanded(child: _showCategoryCircularWidget(cardObject))
                      ],
                    ),
                    CustomWidget.getDefaultHeightSizedBox(),
                    CustomWidget.getTextWidget(context, '${cardObject.description}')
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _showCategoryCircularWidget(CardObject cardObject){
    return Container(
      alignment: Alignment.center,
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: CustomWidget.getTextWidget(context, '${cardObject.cardCategoryObject?.value}'),
    );
  }


}
