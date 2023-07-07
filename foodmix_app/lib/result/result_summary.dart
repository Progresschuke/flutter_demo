import 'package:flutter/material.dart';
import 'package:foodmix_app/result/result_structure.dart';

class ResultSummary extends StatelessWidget {
  const ResultSummary({super.key, required this.itemData});

  final List<Map<String, Object>> itemData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: itemData.map(
            (data) {
              return ResultStructure(itemData: data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
