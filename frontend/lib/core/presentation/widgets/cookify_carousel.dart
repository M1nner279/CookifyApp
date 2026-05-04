import 'package:cookify/core/presentation/widgets/cookify_network_or_file_image.dart';
import 'package:flutter/material.dart';

class CookifyCarousel extends StatefulWidget {
  const CookifyCarousel({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<CookifyCarousel> createState() => _CookifyCarouselState();
}

class _CookifyCarouselState extends State<CookifyCarousel> {
  late final _controller = PageController(initialPage: 0);
  int _activeIndicatorIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        color: const Color(0xFF2C1C16),
        child: const Center(
          child: Icon(
            Icons.photo_size_select_actual,
            size: 48.0,
            color: Color(0x1AE5C9A8),
          ),
        ),
      );
    }

    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              _activeIndicatorIndex = value;
            });
          },
          itemBuilder: (context, index) => SizedBox.expand(
            child: cookifyNetworkOrFileImage(widget.imageUrls[index]),
          ),
          itemCount: widget.imageUrls.length,
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 16.0,
          child: _Indicator(
            activeIndicatorIndex: _activeIndicatorIndex,
            length: widget.imageUrls.length,
          ),
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.activeIndicatorIndex, required this.length});

  final int activeIndicatorIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.0,
      children: List.generate(length, (i) {
        final active = i == activeIndicatorIndex;

        return AnimatedContainer(
          decoration: BoxDecoration(
            color: active ? const Color(0xFFE5C9A8) : const Color(0x4D000000),
            border: Border.all(
              color: active ? const Color(0xFF2C1C16) : const Color(0x33FFFFFF),
              width: active ? 0.5 : 1.0,
            ),
            borderRadius: BorderRadius.circular(9999.0),
          ),
          width: active ? 24.0 : 6.0,
          height: 6.0,
          duration: const Duration(milliseconds: 200),
        );
      }),
    );
  }
}
