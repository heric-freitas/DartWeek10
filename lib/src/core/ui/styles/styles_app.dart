import 'package:flutter/material.dart';

import 'colors_app.dart';
import 'text_styles.dart';

class StylesApp {
  static StylesApp? _instance;
  // Avoid self isntance
  StylesApp._();
  static StylesApp get instance{
    _instance??=  StylesApp._();
    return _instance!;
   }

   ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    backgroundColor: ColorsApp.instance.primary,
    textStyle: TextStyles.instance.textButtonLabel,
   );
}

extension AppStylesExtension on BuildContext {
  StylesApp get stylesApp => StylesApp.instance;
}