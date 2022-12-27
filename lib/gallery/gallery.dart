import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'grey_bg_button.dart';
import 'grid_gallery.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key, required this.images}) : super(key: key);

  final List<String> images;
  static const String routeName = "/gallery";

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late PageController _pageController;
  late TransformationController _transformationController;
  ScrollPhysics? _scrollPhysics;
  int index = 0;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController()
      ..addListener(() {
        if (_transformationController.value.getMaxScaleOnAxis() == 1) {
          setState(() {
            _scrollPhysics = null;
          });
        } else {
          setState(() {
            _scrollPhysics = const NeverScrollableScrollPhysics();
          });
        }
      });
    _pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {
          index = (_pageController.page ?? 0).toInt();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Material(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onDoubleTap: doubleTap,
              onDoubleTapDown: (details) => _doubleTapDetails = details,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 1,
                  maxScale: 5.0,
                  child: PageView.builder(
                    physics: _scrollPhysics,
                    controller: _pageController,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: widget.images[index],
                        placeholder: (_, __) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (_, __, ___) =>
                            const Center(child: Icon(Icons.error)),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (index != 0)
              GreyBgButton(
                left: orientation == Orientation.portrait ? 4 : 50,
                top: screenSize.height * 0.5,
                icon: Icons.arrow_back_ios,
                onPressed: decrement,
              ),
            if (index != widget.images.length - 1)
              GreyBgButton(
                right: orientation == Orientation.portrait ? 4 : 50,
                top: screenSize.height * 0.5,
                icon: Icons.arrow_forward_ios,
                onPressed: increment,
              ),
            GreyBgButton(
              top: 30,
              left: 15,
              icon: Icons.arrow_back,
              onPressed: () => Navigator.pop(context),
            ),
            GreyBgButton(
              top: 30,
              right: 15,
              icon: Icons.apps,
              onPressed: openGridGallery,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "${index + 1}/${widget.images.length}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doubleTap() {
    if (_transformationController.value.getMaxScaleOnAxis() != 1) {
      _transformationController.value = Matrix4.identity();
      return;
    }
    if (_doubleTapDetails == null) return;
    final position = _doubleTapDetails!.localPosition;

    _transformationController.value = Matrix4.identity()
      // ..translate(-position.dx * 2, -position.dy * 2)
      // ..scale(3.0);
      ..translate(-position.dx, -position.dy)
      ..scale(2.0);
  }

  void increment() {
    setState(() {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    });
  }

  void decrement() {
    setState(() {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    });
  }

  void openGridGallery() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return GridGallery(images: widget.images);
        },
      ),
    ).then((value) {
      if (value != null) {
        setState(() => index = value);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 150),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }
}
