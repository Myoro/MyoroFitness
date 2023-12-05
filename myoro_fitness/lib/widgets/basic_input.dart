import "package:flutter/material.dart";
import "package:flutter/services.dart";

enum BasicInputEnum { digitsOnly }

class BasicInput extends StatefulWidget {
  final double? width;
  final double height;
  final Function? onChanged;
  final BasicInputEnum? textType;
  final bool centered;

  const BasicInput({
    super.key,
    this.width,
    this.height = 40,
    this.onChanged,
    this.textType,
    this.centered = false,
  });

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
      height: widget.height,
      width: widget.width,
      child: TextField(
        textAlign: widget.centered ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.bodyMedium,
        controller: controller,
        inputFormatters: [
          (widget.textType == BasicInputEnum.digitsOnly)
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.allow(RegExp('.*'))
        ],
        onChanged: (value) { if(widget.onChanged != null) widget.onChanged!(value); },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onPrimary), // Change color for focused state
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onPrimary), // Change color for default state
          ),
        ),
      ),
    );
  }
}