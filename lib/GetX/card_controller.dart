import 'package:get/get.dart';
import 'package:deepika_assignment/ApiHandler/api_handler.dart';
import 'package:deepika_assignment/Model/card_object.dart';

class CardController extends GetxController{

  List<CardObject>? listOfCards = [];

  int getCount() => listOfCards?.length ?? 0;

  @override
  void onInit() {
    super.onInit();
    hitApiAndGetCardData();
  }

  void hitApiAndGetCardData(){
    var response = ApiHandler.instance.getCardData();
    listOfCards ??= [];
    listOfCards?.addAll(response);
    update();
  }

  void addNewCardObject(CardObject cardObject){
    listOfCards?.insert(0, cardObject);
    update();
  }
}