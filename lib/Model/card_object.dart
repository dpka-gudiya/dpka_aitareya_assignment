
import 'package:deepika_assignment/Utils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/ListOfObjectsUtils.dart';
import 'card_category_object.dart';

class CardObject{
  String? name;
  String? description;
  String? images;
  CardCategoryObject? cardCategoryObject;

  CardObject({this.name, this.description, this.images, this.cardCategoryObject});

  static CardObject getRandomObject() => CardObject(
    name: ListOfObjectsUtils.instance.getRandomNames(),
    description: ListOfObjectsUtils.instance.getRandomDescription(),
    images: ListOfObjectsUtils.instance.getRandomImage(),
    cardCategoryObject: ListOfObjectsUtils.instance.getRandomCategory(),
  );

  bool isValid(BuildContext context) {
    if(_isValueNotValid(images)) {
      ToastUtils.show('Image can not be empty');
      return false;
    }

    if(_isValueNotValid(name)) {
      ToastUtils.show('Name can not be empty');
      return false;
    }
    if(_isValueNotValid(description)) {
      ToastUtils.show('Description can not be empty');
      return false;
    }

    return true;
  }

  bool _isValueNotValid(String? value) {
    if(value == null) {
      return true;
    } else if(value.isEmpty) {
      return true;
    }

    return false;
  }
}