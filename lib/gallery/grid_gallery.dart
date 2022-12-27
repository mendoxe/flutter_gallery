import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridGallery extends StatelessWidget {
  const GridGallery({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
          children: List.generate(
            images.length,
            (index) => InkWell(
              onTap: () => Navigator.pop(context, index),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
