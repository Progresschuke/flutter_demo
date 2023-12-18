import 'package:chat_gpt_clone/constants/app_colors.dart';
import 'package:chat_gpt_clone/constants/dummy_data.dart';
import 'package:flutter/material.dart';

class DropdownModels extends StatefulWidget {
  const DropdownModels({super.key});

  @override
  State<DropdownModels> createState() => _DropdownModelsState();
}

class _DropdownModelsState extends State<DropdownModels> {
  String currentModel = 'Model 1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: AppColors.scaffoldBgColor,
      value: currentModel,
      items: getModelList,
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }
}
