import 'package:adsgroo_task1/util/mcq_model.dart';
import 'package:flutter/material.dart';


class AnalysisPage extends StatelessWidget {
  final List<McqModel> questions;
  final List<int> selectedOptions;

  AnalysisPage({required this.questions, required this.selectedOptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Page'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          McqModel question = questions[index];
          int selectedOptionIndex = selectedOptions[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1}:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(question.question),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: question.options.length,
                    itemBuilder: (context, optionIndex) {
                      String option = question.options[optionIndex];
                      return ListTile(
                        leading: Icon(
                          optionIndex == question.correctOptionIndex
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: optionIndex == selectedOptionIndex
                              ? (optionIndex == question.correctOptionIndex
                              ? Colors.green
                              : Colors.red)
                              : Colors.grey,
                        ),
                        title: Text(option),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
