import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
import 'dart:js' as js;
import 'dart:typed_data';
void main() {
  runApp(MyApp());
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("route 2 page (address bar updated)"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
            Navigator.pop(context);
          },
          child: Text('Go to home'),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  String data;
  ImageScreen({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("route 2 page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(this.data),
            RaisedButton(
              onPressed: () {
                // Navigate back to first screen when tapped.
                Navigator.pop(context);
              },
              child: Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}


class scrollScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("scroll screen test"),
      ),
      body:  GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline,
            ),
          );
        }),
      )

    );
  }
}





class WebcamPage extends StatefulWidget {
  @override
  _WebcamPageState createState() => _WebcamPageState();
}
class _WebcamPageState extends State<WebcamPage> {
  // Webcam widget to insert into the tree
  Widget _webcamWidget;
  // VideoElement
  VideoElement _webcamVideoElement;
  @override
  void initState() {
    super.initState();
    // Create a video element which will be provided with stream source
    _webcamVideoElement = VideoElement();
    // Register an webcam
    ui.platformViewRegistry.registerViewFactory('webcamVideoElement', (int viewId) => _webcamVideoElement);
    // Create video widget
    _webcamWidget = HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement');
    // Access the webcam stream
    window.navigator.getUserMedia(video: true).then((MediaStream stream) {
      _webcamVideoElement.srcObject = stream;
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              // Navigate back to first screen when tapped.

              _webcamVideoElement.srcObject.active ? _webcamVideoElement.play() : _webcamVideoElement.pause();

            },
            child: Text('Turn on Web Camera'),
          ),
          RaisedButton(
            onPressed: () async {
              var track = _webcamVideoElement.srcObject.getVideoTracks()[0];
              print(_webcamVideoElement.srcObject.getVideoTracks()[0]);
              var ic = ImageCapture(track);
              var test = await ic.takePhoto();

              print(test);
              _webcamVideoElement.pause();
              Navigator.pop(context, test);


              // Navigate back to first screen when tapped.
//              Navigator.pop(context);

            },
            child: Text('Capture Photo and go home'),
          ),


          Container(width: 750, height: 750, child: _webcamWidget),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _webcamVideoElement.srcObject.active ? _webcamVideoElement.play() : _webcamVideoElement.pause(),
      tooltip: 'Start stream, stop stream',
      child: Icon(Icons.camera_alt),
    ),
  );
}




class MicrophonePage extends StatefulWidget {
  @override
  MicrophonePageState createState() => MicrophonePageState();
}
class MicrophonePageState extends State<MicrophonePage> {
  // Webcam widget to insert into the tree
  Widget _webcamWidget;
  // VideoElement
  AudioElement _webcamAudioElement;
  @override
  void initState() {
    super.initState();
    // Create a video element which will be provided with stream source
    _webcamAudioElement = AudioElement();
    // Register an webcam
    ui.platformViewRegistry.registerViewFactory('webcamVideoElement', (int viewId) => _webcamAudioElement);
    // Create video widget
    _webcamWidget = HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement');
    // Access the webcam stream
    window.navigator.getUserMedia(audio: true).then((MediaStream stream) {
      _webcamAudioElement.srcObject = stream;
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              // Navigate back to first screen when tapped.

              _webcamAudioElement.srcObject.active ? _webcamAudioElement.play() : _webcamAudioElement.pause();

            },
            child: Text('Turn on audio'),
          ),
          RaisedButton(
            onPressed: () async {
              var track = _webcamAudioElement.srcObject.getVideoTracks()[0];
              print(_webcamAudioElement.srcObject.getVideoTracks()[0]);
              var ic = ImageCapture(track);
              var test = await ic.takePhoto();

              print(test);
              _webcamAudioElement.pause();
              Navigator.pop(context, test);


              // Navigate back to first screen when tapped.
//              Navigator.pop(context);

            },
            child: Text('Capture audio and go home'),
          ),


          Container(width: 750, height: 750, child: _webcamWidget),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _webcamAudioElement.srcObject.active ? _webcamAudioElement.play() : _webcamAudioElement.pause(),
      tooltip: 'Start or stop playback',
      child: Icon(Icons.audiotrack),
    ),
  );
}





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '': (context) => MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
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
  int _counter = 0;
  String result = "none";
  Uint8List preview = null;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

        RaisedButton(
          onPressed: () {

            Navigator.pushNamed(context, '/second');
          },
          child: Text("Test1:Route"),
        ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageScreen(data:"https://i.imgur.com/EzAeGcr.jpg")),
                );


              },
              child: Text("Test2:Download_image"),

            ),
            RaisedButton(
              onPressed: () async {
                var queryParameters = {
                  'param1': 'ho',
                  'param2': 'hi',
                };

                var test = await http.get('https://httpbin.org/get');
                print(test.body);

                setState(() {
                  result = test.body;
                });
              },
              child: Text("Test3:get request"),
            ),
            RaisedButton(
              onPressed: () async {
                Map<String, String> body = {
                  'question': 'who is the best talkshow host?',
                  'answer': 'conan O\'Brien',
                };

                var r = await http.post(
                  'http://httpbin.org/post',
                  headers: { 'Content-type': 'application/json',
                    'Accept': 'application/json',
                    },
                  body: json.encode(body),
                );


                print(r.body);

                setState(() {
                  result = r.body;
                });
              },
              child: Text("Test4:post request"),
            ),
            RaisedButton(
              onPressed: () async {

                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebcamPage()),
                );
                if (data != null){


                    final reader = new FileReader();

                    reader.onLoadEnd.listen((e) {

                      setState(() {
                        preview = reader.result;
                      });

                    });
                    reader.readAsArrayBuffer(data);



                }
              },
              child: Text("Test5: Web Cam"),
            ),



            RaisedButton(
              child: Text("Test6: Javascript call"),
              onPressed: () async {
                js.context.callMethod('alert', ['Hello conan, from javascript!']);
              },

            ),

            RaisedButton(
              child: Text("Test7: upload file"),
              onPressed: () async {
                var test;
                InputElement uploadInput = FileUploadInputElement();
                uploadInput.click();

                uploadInput.onChange.listen((e) {
                  // read file content as dataURL
                  final files = uploadInput.files;
                  if (files.length == 1) {
                    final file = files[0];
                    final reader = new FileReader();

                    reader.onLoadEnd.listen((e) {

                      setState(() {
                        preview = reader.result;
                      });
                      print(test);
                    });
                       reader.readAsArrayBuffer(file);

                  }
                });
              },

            ),



            RaisedButton(
              onPressed: () async {

                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MicrophonePage()),
                );
                if (data != null){


                  final reader = new FileReader();

                  reader.onLoadEnd.listen((e) {

                    setState(() {
                      preview = reader.result;
                    });

                  });
                  reader.readAsArrayBuffer(data);



                }
              },
              child: Text("Test8: Test Microphone"),
            ),
            RaisedButton(
              onPressed: () async {

                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => scrollScreen()),
                );

              },
              child: Text("Test9: Test Scroll"),
            ),


            RaisedButton(
              onPressed: () async {

                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Summary()),
                );

              },
              child: Text("Summary Report"),
            ),





            preview == null
                ? Text("no media")
                : new Image.memory(preview),






            Text(

              '$result',
            ),






          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sumamry"),
        ),
        body:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("1. You can not right click and select elemets. This could be a good thing or a bad thing"),
            Text("2. Scrolling is wired compared to traditional browser"),
            Text("3. No support for accessibility on desktop"),
            Text("4. Site will fail if you have javascript disabled"),
            Text("4. You cannot select text by default (by dragging cursor)"),
            SelectableText(
              'Example of selectable text',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("5. SEO and google indexing, site crawler fails. (could be good thing for us) "),
            Text("6. Control + Find can only search what's displaed on the page "),
          ],
        )

    );
  }
}