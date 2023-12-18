import 'package:flutter/material.dart';

const dummyChat = [
  {
    'msg': 'Hello, how can I help you?',
    'chatIndex': 0,
  },
  {
    'msg':
        'What is the meaning of flutter? What is the meaning of flutter?What is the meaning of flutter?What is the meaning of flutter?What is the meaning of flutter?',
    'chatIndex': 1,
  },
  {
    'msg':
        'Flutter is a free and open-source UI SDKWhat is the meaning of flutter?What is the meaning of flutter?What is the meaning of flutter?',
    'chatIndex': 0,
  },
  {
    'msg': 'Thank you',
    'chatIndex': 1,
  }
];

List<String> modelList = [
  'Model 1',
  'Model 2',
  'Model 3',
  'Model 4',
  'Model 5'
];

List<DropdownMenuItem<Object?>>? get getModelList {
  List<DropdownMenuItem<Object?>>? modelListItem =
      List<DropdownMenuItem<String?>>.generate(
          modelList.length,
          (index) => DropdownMenuItem(
                value: modelList[index],
                child: Text(
                  modelList[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ));

  return modelListItem;
}
