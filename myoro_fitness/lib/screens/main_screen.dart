import "dart:io";
import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/top_bars/main_screen_top_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/footer_navigation_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/side_navigation_bar.dart";
import "package:myoro_fitness/pages/calories_page.dart";

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainScreenTopBar(),
      body: (Platform.isAndroid || Platform.isIOS)
        ? const Column(
          children: [
            CaloriesPage(),
            FooterNavigationBar()
          ]
        )
        :
        const Row(
          children: [
            SideNavigationBar(),
            CaloriesPage()
          ]
        )
    );
  }
}