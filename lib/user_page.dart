import 'package:adsgroo_task1/util/mcq_model.dart';
import 'package:flutter/material.dart';
import 'analysis_page.dart';
import 'main.dart';

class UserPage extends StatefulWidget {
  final List<McqModel> questions;

  UserPage({required this.questions});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<int> selectedOptions = List.filled(sampleQuestions.length, -1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          McqModel question = widget.questions[index];
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
                      return RadioListTile<int>(
                        title: Text(option),
                        value: optionIndex,
                        groupValue: selectedOptions[index],
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value!;
                          });
                        },
                        secondary: selectedOptions[index] == optionIndex
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnalysisPage(
                questions: sampleQuestions,
                selectedOptions: selectedOptions,
              ),
            ),
          );
        },
        child: Icon(Icons.analytics),
      ),
    );
  }
}
