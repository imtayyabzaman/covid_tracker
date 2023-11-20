import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';

class JokeScreen extends StatefulWidget {
  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final llm = FakeListLLM(
    responses: ['Why did the AI go on a diet? Because it had too many bytes!'],
  );
  String result = '';

  @override
  void initState() {
    super.initState();
    _fetchJoke();
  }

  Future<void> _fetchJoke() async {
    final promptTemplate = PromptTemplate.fromTemplate(
      'tell me a joke about {subject}',
    );
    final prompt = promptTemplate.format({'subject': 'AI'});
    final joke = await llm(prompt);
    setState(() {
      result = joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            result,
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
