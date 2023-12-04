import "package:flutter/material.dart";

class BasicDropdown extends StatefulWidget {
  final List<String> items;
  final EdgeInsets itemPadding;
  final Function? onChanged;
  final double? width;

  const BasicDropdown({
    super.key,
    required this.items,
    this.itemPadding = EdgeInsets.zero,
    this.onChanged,
    this.width
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
    return SizedBox(
      width: widget.width,
      child: DropdownButton<String>(
        menuMaxHeight: 200,
        isExpanded: true,
        value: value,
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: widget.itemPadding,
              child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
            )
          );
        }).toList(),
        onChanged: (value) {
          widget.onChanged!(value!);
          setState(() { this.value = value; });
        }
      ),
    );
  }
}