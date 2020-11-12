import 'package:diariosaude/media/media_query.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  
  TopContainer({this.height, this.width, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: ThemeColors.primary,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(SizeConfig.of(context).dynamicScaleSize(size: 40)),
            bottomLeft: Radius.circular(SizeConfig.of(context).dynamicScaleSize(size: 40)),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
