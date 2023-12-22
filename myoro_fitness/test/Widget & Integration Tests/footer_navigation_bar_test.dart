import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_fitness/bloc/page_control_bloc.dart';
import 'package:myoro_fitness/widgets/buttons/navigation_bar_button.dart';
import 'package:myoro_fitness/widgets/navigation_bar/footer_navigation_bar.dart';

void main() {
  testWidgets("FooterNavigationBar Widget Test", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        title: "FooterNavigationBar Widget Test",
        home: Scaffold(
          body: FooterNavigationBar(selected: PageControlEnum.calories)
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBarButton), findsNWidgets(3));
  });
}