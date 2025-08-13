import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

const kBlue1 = Color(0xFF1D77F2);
const kBlue2 = Color(0xFF0EB5FF);

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final _controller = CarouselSliderController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final imgs = widget.images.isNotEmpty
        ? widget.images
        : const ['https://via.placeholder.com/600x400?text=No+image'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(color: Colors.white),
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: imgs.length,
            itemBuilder: (_, i, __) {
              final url = imgs[i];
              return Container(
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                  cacheKey: url,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.broken_image_outlined,
                    size: 48,
                    color: Colors.black26,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: imgs.length > 1,
              autoPlay: false,
              onPageChanged: (i, reason) => setState(() => _index = i),
            ),
          ),
          if (imgs.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _Dots(count: imgs.length, index: _index),
            ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int index;
  const _Dots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 6,
          width: isActive ? 14 : 6,
          decoration: BoxDecoration(
            color: isActive ? kBlue1 : Colors.black26,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}