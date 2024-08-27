import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';



class CustomButton extends StatefulWidget {
  final double width;
  final double height;
  final String title;
  final Function() onTapped;

  const CustomButton({required this.width,required this.height,required this.title,required this.onTapped,super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTapped();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorResource.app_theme_color
        ),
        child: Center(child: Text(widget.title,style: button_style.copyWith(color: ColorResource.app_bg_color),)),
      ),
    );
  }
}
