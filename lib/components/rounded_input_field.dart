import 'package:flutter/material.dart';
import 'package:dfidmobilen/components/text_field_container.dart';
import 'package:dfidmobilen/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.readOnly,
    this.enableInteractiveSelection,
    this.icon = Icons.person,
    this.onChanged,
    TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
