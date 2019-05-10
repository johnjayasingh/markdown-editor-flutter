import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markdown Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Markdown Editor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _html = '<h1>john</h1>';
  String _value =
      '**Angular** is a TypeScript based //opensource// front-end web application platform. [[https://angular.io/|Learnmore]]';

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: _value);
    this._onFieldSubmitted(_value);
  }

  void _onFieldSubmitted(String text) {
    RegExp bold = new RegExp(r"\*\*(.*?)\*\*");
    RegExp italic = new RegExp(r"\/\/(.*?)\/\/");
    RegExp anchor = new RegExp(r"\[\[(.*?)[|](.*?)\]\]");

    text = text.replaceAllMapped(bold, (match) {
      return '<b>${match.group(1)}</b>';
    });
    text = text.replaceAllMapped(italic, (match) {
      return '<i>${match.group(1)}</i>';
    });
    text = text.replaceAllMapped(anchor, (match) {
      return '<a link="${match.group(1)}" target="_blank">${match.group(2)}</a>';
    });
    setState(() {
      _html = '<div>${text}</div>';
      _value = text;
    });
  }

  void _onConvertPressed() {
    print(_value);
  }

  void _makeSelectedBold() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
                enableInteractiveSelection: true,
                onChanged: _onFieldSubmitted,
                minLines: 10,
                maxLines: 10,
                decoration: InputDecoration(
                    labelText: 'Markdown',
                    hasFloatingPlaceholder: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x666666)))),
              ),
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    color: Colors.black54,
                    onPressed: _onConvertPressed,
                    child: Text(
                      'B',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.blueGrey,
                    onPressed: _onConvertPressed,
                    child: Text(
                      'I',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ),
                  FlatButton(
                    color: Colors.blueAccent,
                    onPressed: _onConvertPressed,
                    child: Text(
                      'Link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.lightBlue,
                child: HtmlView(
                  data: '$_html',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
