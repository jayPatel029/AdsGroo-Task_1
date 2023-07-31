import 'package:flutter/material.dart';
import 'package:adsgroo_task1/util/mcq_model.dart';


class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController questionController = TextEditingController();
  List<TextEditingController> optionControllers = [];
  int correctOptionIndex = 0;

  void _addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    setState(() {
      optionControllers.removeAt(index);
    });
  }

  void _addQuestion() {
    String question = questionController.text.trim();
    List<String> options = optionControllers.map((controller) => controller.text.trim()).toList();

    if (question.isNotEmpty && options.isNotEmpty) {
      if (correctOptionIndex >= 0 && correctOptionIndex < options.length) {
        McqModel mcqQuestion = McqModel(
          question: question,
          options: options,
          correctOptionIndex: correctOptionIndex,
        );


        print(mcqQuestion);

        questionController.clear();
        optionControllers.clear();
        correctOptionIndex = 0;
      } else {
        _showSnackbar('Please select a valid correct option.');
      }
    } else {
      _showSnackbar('Please enter the question and at least one option.');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: optionControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: optionControllers[index],
                          decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeOption(index),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addOption,
                child: Text('Add Option'),
              ),
              SizedBox(height: 16),
              DropdownButton<int>(
                value: correctOptionIndex,
                onChanged: (index) => setState(() => correctOptionIndex = index!),
                items: optionControllers
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text('Correct Option ${index + 1}'),
                  );
                })
                    .toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addQuestion,
                child: Text('Add Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
