import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/top_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/footer_navigation_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/side_navigation_bar.dart";

class MainScreen extends StatelessWidget {
  const MainScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    final double screenWidth  = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const TopBar(),
      body: (screenWidth < screenHeight)
        ? Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey
              )
            ),
            const FooterNavigationBar()
          ]
        )
        :
        Row(
          children: [
            const SideNavigationBar(),
            Expanded(
              child: Container(
                color: Colors.grey
              )
            )
          ]
        )
    );
  }
}