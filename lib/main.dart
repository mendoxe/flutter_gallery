import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/gallery/gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.bahamaBlue),
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Camera"),
        actions: [
          IconButton(
            icon: const Icon(Icons.hot_tub),
            onPressed: () {},
          )
        ],
      ),
      body: const Center(
        child: Text("To show images click the FAB..."),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openGallery,
        isExtended: true,
        child: const Icon(Icons.photo),
      ),
    );
  }

  Future<void> _openGallery() async {
    List<String> images = [
      "https://picsum.photos/500?random=1",
      "https://picsum.photos/500?random=2",
      "https://picsum.photos/500?random=3",
      "https://picsum.photos/500?random=4",
      "https://picsum.photos/500?random=5",
    ];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Gallery(images: images);
        },
      ),
    );
  }
}
