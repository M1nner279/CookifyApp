import 'package:cookify/shared/presentation/widget/cookify_cached_network_image.dart';
import 'package:flutter/material.dart';

class CookifyCarousel extends StatefulWidget {
  const CookifyCarousel({super.key, required this.photoUrls});

  final List<String> photoUrls;

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
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              _activeIndicatorIndex = value;
            });
          },
          itemBuilder: (context, index) =>
              CookifyCachedNetworkImage(widget.photoUrls[index]),
          itemCount: widget.photoUrls.length,
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 16.0,
          child: _Indicator(
            activeIndicatorIndex: _activeIndicatorIndex,
            length: widget.photoUrls.length,
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
            color: active ? Color(0xFFF5E6D3) : Color(0x4D000000),
            border: active
                ? null
                : Border.all(color: Color(0x33FFFFFF), width: 1.0),
            borderRadius: BorderRadius.circular(9999.0),
          ),
          width: active ? 24.0 : 6.0,
          height: 6.0,
          duration: Duration(milliseconds: 200),
        );
      }),
    );
  }
}
