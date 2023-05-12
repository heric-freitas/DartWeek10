import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import 'menu/menu_bar.dart' as menu;
class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final screenShortestSide = context.screenShortestSide;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.black,
              constraints: BoxConstraints(
                minWidth: screenWidth,
                minHeight: screenShortestSide * .15,
                maxHeight: screenShortestSide * .15,
              ),
              child: Container(
                width: screenShortestSide * .13,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Positioned.fill(
              top: screenShortestSide * .13,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: Colors.grey[50]!,
                        child: body,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
