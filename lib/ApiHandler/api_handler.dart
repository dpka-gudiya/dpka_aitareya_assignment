
import '../Model/card_object.dart';

class ApiHandler{

  static final instance = ApiHandler();

  final int _countOfElementToReturnViaApi = 5;

  List<CardObject> getCardData(){
    var _listOfAllCardData = <CardObject>[];

    for(int index = 0 ; index < _countOfElementToReturnViaApi; index++) {
      var getRandomCardObjectItem = CardObject.getRandomObject();
      _listOfAllCardData.add(getRandomCardObjectItem);
    }

    return _listOfAllCardData;
  }

}