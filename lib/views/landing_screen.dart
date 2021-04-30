import 'package:flutter/material.dart';
import 'package:paysliptask/views/mobile/mobile_screen.dart';
import 'package:paysliptask/views/tablet/tablet_screen.dart';
import 'package:paysliptask/views/web/web_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if(size.isDesktop){
          return WebScreen();
        }

        if(size.isTablet){
          return TabletScreen();
        }

        if(size.isMobile){
          return MobileScreen();
        }
      },
    );
  }
}
