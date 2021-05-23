import 'package:flutter/material.dart';
import 'package:time_tracker_app/core/constants/constants.dart';

class ActivityFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final validator;

  const ActivityFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: hintText,
        hintStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
      ),
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: kGrayColor.withOpacity(0.7)),
      validator: validator,
    );
  }
}
