import 'package:flutter/material.dart';

class ContainerBorderTheme extends ThemeExtension<ContainerBorderTheme>{

  final Border border;

  ContainerBorderTheme({required this.border});

  @override
  ThemeExtension<ContainerBorderTheme> copyWith() {
    return ContainerBorderTheme(border: border?? this.border);
  }

  @override
  ThemeExtension<ContainerBorderTheme> lerp(covariant ThemeExtension<ContainerBorderTheme>? other, double t) {
    if(other is! ContainerBorderTheme){
      return this;
    }

    return ContainerBorderTheme(border: Border.lerp(this.border, other.border, t)!,);
  }

}