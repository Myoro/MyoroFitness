import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myoro_fitness/bloc/page_control_bloc.dart";
import "package:myoro_fitness/pages/tracking_page.dart";
import "package:myoro_fitness/widgets/top_bars/main_screen_top_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/footer_navigation_bar.dart";
import "package:myoro_fitness/widgets/navigation_bar/side_navigation_bar.dart";
import "package:myoro_fitness/pages/calories_page.dart";

class MainScreen extends StatelessWidget {
  const MainScreen({ super.key });

  Widget displayPage(PageControlEnum page) {
    switch(page) {
      case PageControlEnum.calories: return const CaloriesPage();
      case PageControlEnum.tracking: return const TrackingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageControlBloc, PageControlState>(
      builder: (context, state) => Scaffold(
        appBar: const MainScreenTopBar(),
        body: (Platform.isAndroid || Platform.isIOS)
          ? Column(
            children: [
              displayPage(state.currentPage),
              const FooterNavigationBar()
            ]
          )
          :
          Row(
            children: [
              const SideNavigationBar(),
              displayPage(state.currentPage)
            ]
          )
      )
    );
  }
}