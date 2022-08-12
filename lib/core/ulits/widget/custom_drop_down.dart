import 'package:flutter/material.dart';
import 'package:to_do_app/core/ulits/widget/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final String? value;
  final IconData icon;
  final List<String> items;
  ValueChanged<String>? onChange;
  final VoidCallback press;
  CustomDropDown(
      {Key? key,
      required this.value,
      required this.items,
      required this.icon,
      this.onChange,
      required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        icon: Icon(
          icon,
          size: 35,
          color: Colors.grey[400],
        ),
        items: items.map(buildMenuItem).toList(),
        onChanged: (value) => onChange,
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      onTap: press,
      value: item,
      child: CustomText(
        text: item,
        
      ),
    );
  }
}
