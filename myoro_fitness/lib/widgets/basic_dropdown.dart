import "package:flutter/material.dart";

class BasicDropdown extends StatefulWidget {
  final List<String> items;
  final EdgeInsets itemPadding;
  final Function? onChanged;
  final double? width;
  final double height;
  final bool centered;
  final TextStyle? textStyle;

  const BasicDropdown({
    super.key,
    required this.items,
    this.itemPadding = EdgeInsets.zero,
    this.onChanged,
    this.width,
    this.height = 40,
    this.centered = false,
    this.textStyle
  });

  @override
  State<BasicDropdown> createState() => _BasicDropdownState();
}

class _BasicDropdownState extends State<BasicDropdown> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButton<String>(
        isDense: true,
        menuMaxHeight: 200,
        isExpanded: true,
        value: value,
        underline: Container(height: 2, color: theme.colorScheme.onPrimary.withOpacity(0.55)),
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            alignment: widget.centered ? Alignment.center : AlignmentDirectional.centerStart,
            value: item,
            child: Padding(
              padding: widget.itemPadding,
              child: Text(
                item,
                style: (widget.textStyle == null) ? theme.textTheme.bodyMedium : widget.textStyle
              ),
            )
          );
        }).toList(),
        onChanged: (value) {
          if(widget.onChanged != null) widget.onChanged!(value!);
          setState(() { this.value = value!; });
        }
      )
    );
  }
}