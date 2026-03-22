import 'package:cookify/common/presentation/widget/cookify_cached_network_image.dart';
import 'package:cookify/core/theme/t.dart';
import 'package:flutter/material.dart';

class RecipePhotoSection extends StatefulWidget {
  const RecipePhotoSection({super.key, required this.photoUrls});

  final List<String> photoUrls;

  @override
  State<RecipePhotoSection> createState() => _RecipePhotoSectionState();
}

class _RecipePhotoSectionState extends State<RecipePhotoSection> {
  late final _controller = PageController(initialPage: 0);
  int _indicatorIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: widget.photoUrls[0],
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _indicatorIndex = value;
                });
              },
              itemBuilder: (context, index) =>
                  CookifyCachedNetworkImage(widget.photoUrls[index]),
              itemCount: widget.photoUrls.length,
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 4.0,
          child: _Indicator(
            index: _indicatorIndex,
            length: widget.photoUrls.length,
          ),
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.index, required this.length});

  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2.0,
      children: List.generate(length, (i) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            color: T.primary(context),
            border: Border.all(color: T.secondary(context)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          width: i == index ? 25.0 : 10.0,
          height: 10.0,
          duration: Duration(milliseconds: 100),
        );
      }),
    );
  }
}
