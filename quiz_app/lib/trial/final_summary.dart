// import 'package:basic_app/result.dart/question_identifier.dart';

import 'package:basic_app/trial/summary_answer.dart';
import 'package:flutter/material.dart';

class FinalSummary extends StatelessWidget {
  const FinalSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryAnswer(summary: data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
