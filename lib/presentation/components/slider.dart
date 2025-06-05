import 'package:carousel_slider/carousel_slider.dart'
    as car;
import 'package:flutter/material.dart';

class ImageSliderDemo extends StatefulWidget {
  final List<String> imgList;

  const ImageSliderDemo({required this.imgList, Key? key})
      : super(key: key);

  @override
  State<ImageSliderDemo> createState() =>
      _ImageSliderDemoState();
}

class _ImageSliderDemoState extends State<ImageSliderDemo> {
  final car.CarouselController buttonCarouselController =
      car.CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: car.CarouselSlider(
              options: car.CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              disableGesture: true,
              carouselController: buttonCarouselController,
              items: widget.imgList
                  ?.map((item) => Center(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: Image.network(
                            item ?? '',
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList
                .asMap()
                .entries
                .take(4)
                .map((entry) {
              return GestureDetector(
                onTap: () => buttonCarouselController
                    .animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key
                            ? 0.9
                            : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
