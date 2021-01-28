import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class RandomWords extends StatefulWidget {
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWords> {
  final _suggesstions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18);

  Widget _buildSeggesstion() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggesstions.length) {
          _suggesstions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggesstions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSeggesstion();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Word App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Word'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}
