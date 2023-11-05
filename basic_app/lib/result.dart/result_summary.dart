// import 'package:basic_app/result.dart/question_identifier.dart';
import 'package:basic_app/result.dart/summary_item.dart';
import 'package:flutter/material.dart';

class ResultSummary extends StatelessWidget {
  const ResultSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItem(summary: data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
