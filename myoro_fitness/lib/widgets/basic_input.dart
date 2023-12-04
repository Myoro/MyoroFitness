import "package:flutter/material.dart";

class BasicInput extends StatefulWidget {
  final double? width;

  const BasicInput({ super.key, this.width });

  @override
  State<BasicInput> createState() => _BasicInputState();
}

class _BasicInputState extends State<BasicInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 40,
      width: widget.width,
      child: TextField(
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onPrimary), // Change color for focused state
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onPrimary), // Change color for default state
          ),
        ),
        controller: controller
      ),
    );
  }
}