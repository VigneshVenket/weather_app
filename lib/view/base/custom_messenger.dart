
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';


class CustomMessenger {

  static void showMessage(BuildContext context, String message,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style: text_input_style.copyWith(color: Colors.white)),
          backgroundColor: color
      ),
    );

  }
}