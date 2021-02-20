import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: RandomWords(),
      ),
    );
  }
}

/*
 In your IDE, start typing stful.
 The editor asks if you want to create a Stateful widget. Press Return to accept.
 The boilerplate code for two classes appears, and the cursor is positioned for you to enter the name of your stateless widget.
 Enter RandomWords as the name of your widget.
 */
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          // The iterator begins at 0 and increments each time the function is called, once for every suggested word pairing.
          if (i.isOdd) {
            return Divider();
          }
          /*
            The syntax "i ~/ 2" divides i by 2 and returns an integer result.
            For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
            This calculates the actual number of word pairings in the ListView,minus the divider widgets.
          */
          final int index = i ~/ 2;
          // If you've reached the end of the available word pairings...
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }
}
