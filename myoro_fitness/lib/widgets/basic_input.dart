// ignore_for_file: curly_braces_in_flow_control_structures

import "package:flutter/material.dart";
import "package:flutter/services.dart";

enum BasicInputEnum { digitsOnly, decimal }

class BasicInput extends StatefulWidget {
  final double? width;
  final double height;
  final Function? onChanged;
  final BasicInputEnum? textType;
  final bool centered;
  final String? placeholder;
  final TextEditingController? controller;

  const BasicInput({
    super.key,
    this.width,
    this.height = 40,
    this.onChanged,
    this.textType,
    this.centered = false,
    this.placeholder,
    this.controller
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

    late final dynamic textType;
    if(widget.textType == BasicInputEnum.digitsOnly)
      textType = FilteringTextInputFormatter.digitsOnly;
    else if(widget.textType == BasicInputEnum.decimal)
      textType = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
    else
      textType = FilteringTextInputFormatter.allow(RegExp('.*'));

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        textAlign: widget.centered ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.bodyMedium,
        controller: (widget.controller != null) ? widget.controller : controller,
        inputFormatters: [ textType ],
        onChanged: (value) { if(widget.onChanged != null) widget.onChanged!(value); },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onPrimary), // Change color for focused state
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onPrimary), // Change color for default state
          ),
          hintText: widget.placeholder
        ),
      ),
    );
  }
}