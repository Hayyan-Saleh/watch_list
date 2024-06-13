import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';

// ignore: must_be_immutable
class DropDownButton extends StatelessWidget {
  final String buttonTitle;
  final String dropDownTitle;
  final List dataList;
  String? selectedItem;
  DropDownButton({
    required this.dropDownTitle,
    required this.buttonTitle,
    required this.dataList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          DropDownState(
            DropDown(
              dropDownBackgroundColor: primaryColor.withAlpha(150),
              isDismissible: true,
              bottomSheetTitle: Text(
                dropDownTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),
              ),
              data: _generateSelectedListItems(),
              selectedItems: (List<dynamic> selectedList) {
                for (var item in selectedList) {
                  if (item is SelectedListItem) {
                    showSnackBarCustomColor(
                        '${item.name} is Selected ', context, primaryColor);
                    selectedItem = item.name;
                  }
                }
              },
              enableMultipleSelection: false,
            ),
          ).showModal(context);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
        child: Text(
          buttonTitle,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ));
  }

  List<SelectedListItem> _generateSelectedListItems() {
    return dataList
        .map<SelectedListItem>((item) => SelectedListItem(name: item))
        .toList();
  }
}
