import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/widgets/inputs/base_text_field.dart';

/// Where the user may search for foods via API
class FoodSelectionScreenSearchBar extends StatelessWidget {
  /// Will be called to search for whatever [String] is
  final Function(String) onChanged;

  const FoodSelectionScreenSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BaseTextField(
      size: SizeEnum.medium,
      width: screenWidth - 300 > 150 ? screenWidth - 300 : 150,
      onChanged: onChanged,
    );
  }
}
