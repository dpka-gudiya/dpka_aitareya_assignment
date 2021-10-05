import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:deepika_assignment/CustomWidget/custom_widgets.dart';
import 'package:deepika_assignment/GetX/card_controller.dart';
import 'package:deepika_assignment/Model/card_category_object.dart';
import 'package:deepika_assignment/Model/card_object.dart';
import 'package:deepika_assignment/Screens/select_image.dart';
import 'package:deepika_assignment/Utils/ListOfObjectsUtils.dart';
import 'package:deepika_assignment/Utils/app_utils.dart';


class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {

  final _controller = Get.put(CardController());
  String? assetImage;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();


  List<DropdownMenuItem<CardCategoryObject>>? _dropdownMenuItems;
  CardCategoryObject? _selectedCategoryObject;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(ListOfObjectsUtils.instance.getCardCategoriesList());
    _selectedCategoryObject = _dropdownMenuItems![0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomWidget.getTextWidget(context, "Add Item"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
            delegate: SliverChildBuilderDelegate((context, int index) {
               return _buildMainWidget();
             }, childCount: 1)
            ),
          ],
        )
    );
  }

  Widget _buildMainWidget(){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildImageWidget(),
          CustomWidget.getDefaultHeightSizedBox(),
          CustomWidget.getTextField(context, _nameController, "Add name here", onChange: (value){
            _nameController.text = value;
          }),
          CustomWidget.getDefaultHeightSizedBox(),
          CustomWidget.getTextField(context, _descController, "Add Description here", onChange: (value){
            _descController.text = value;
          }),
          CustomWidget.getDefaultHeightSizedBox(),
          _selectCategoryDropDownWidget(),
          CustomWidget.getDefaultHeightSizedBox(height: 48.0),
          _buildSaveButtonWidget()
        ],
      ),
    );
  }



  Widget _buildImageWidget(){
    return GestureDetector(
      child: assetImage!= null ? Container(
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(assetImage!, fit: BoxFit.fill,)
      ) : Container(
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: CustomWidget.getTextWidget(context, "Select image from here"),
      ),
      onTap: () async {
        // Get result from Select Image screen...
        String? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectImage())) as String?;
        if(result != null){
          assetImage = result;
          AppUtils.refreshCurrentState(this);
        }
      },
    );
  }



  List<DropdownMenuItem<CardCategoryObject>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<CardCategoryObject>> items = [];
    for (CardCategoryObject cardCategoryObjectItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(cardCategoryObjectItem.value ?? ''),
          value: cardCategoryObjectItem,
        ),
      );
    }
    return items;
  }


  Widget _selectCategoryDropDownWidget(){
    return Row(
      children: [
        CustomWidget.getTextWidget(context, 'Select Card Category'),
        CustomWidget.getDefaultWidthSizedBox(),
        DropdownButton(
            value: _selectedCategoryObject,
            items: _dropdownMenuItems,
            onChanged: (value) {
              _selectedCategoryObject = value as CardCategoryObject?;
              AppUtils.refreshCurrentState(this);
            }),
      ],
    );
  }

  Widget _buildSaveButtonWidget(){
    return CustomWidget.getRoundedButtonWidget(context, 'Save', onTap: (){
      _onSaveClickEvent();
    });
  }

  void _onSaveClickEvent(){
    var name = _nameController.text;
    var desc = _descController.text;
    var selectedCategory = _selectedCategoryObject;
    var selectedImage = assetImage;
    var addNewCardItem = CardObject(name: name, description: desc, images: selectedImage, cardCategoryObject: selectedCategory);

    if(addNewCardItem.isValid(context)) {
      _controller.addNewCardObject(addNewCardItem);

      Navigator.pop(context);
    }
  }

}
