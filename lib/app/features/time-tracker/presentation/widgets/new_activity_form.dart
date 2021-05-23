import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_list_provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_model.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/widgets/activity_form_field.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/widgets/custom_rounded_button.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/widgets/duration_picker.dart';
import 'package:time_tracker_app/core/utils/string_extension.dart';
import 'package:time_tracker_app/core/constants/constants.dart';

class NewActivityForm extends StatefulWidget {
  final ActivityListProvider state;
  NewActivityForm({Key? key, required this.state}) : super(key: key);

  @override
  _NewActivityFormState createState() => _NewActivityFormState();
}

class _NewActivityFormState extends State<NewActivityForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  ActivityType type = ActivityType.personal;
  String icon = 'work';
  Duration totalTime = Duration(minutes: 30);

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  List<DropdownMenuItem<ActivityType>> _activityTypeDropDownMenuItems() {
    List<DropdownMenuItem<ActivityType>> list = [];

    activityTypeToString.forEach((key, value) {
      DropdownMenuItem<ActivityType> item = DropdownMenuItem(
        child: Text(
          value.capitalize(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        value: key,
      );
      list.add(item);
    });
    return list;
  }

  List<DropdownMenuItem<String>> _iconDropDownMenuItems() {
    List<DropdownMenuItem<String>> list = [];

    stringToIconData.forEach((key, value) {
      DropdownMenuItem<String> item = DropdownMenuItem(
        child: Icon(
          value,
          size: 20.0,
        ),
        value: key,
      );
      list.add(item);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'New Activity',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              ActivityFormField(
                controller: _titleController,
                labelText: 'Title',
                hintText: 'Text',
                validator: (String? str) {
                  if (str == '') {
                    return "Title cannot be empty.";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Type',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<ActivityType>(
                value: type,
                items: _activityTypeDropDownMenuItems(),
                onChanged: (value) {
                  setState(() {
                    type = value!;
                  });
                },
                validator: (ActivityType? value) {
                  if (value == null) {
                    return "Type cannot be empty.";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Icon',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: icon,
                items: _iconDropDownMenuItems(),
                onChanged: (value) {
                  setState(() {
                    icon = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null) {
                    return "Icon cannot be empty.";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              DurationPicker(
                totalTime: totalTime,
                onConfirm: (Picker picker, List<int> value) {
                  // You get your duration here
                  setState(() {
                    totalTime = Duration(
                        hours: picker.getSelectedValues()[0],
                        minutes: picker.getSelectedValues()[1],
                        seconds: picker.getSelectedValues()[2]);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomRoundedButton(
                text: 'Create',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Activity activity = ActivityModel(
                      activityName: _titleController.text,
                      type: type,
                      icon: icon,
                      spentTime: Duration(),
                      totalTime: totalTime,
                    );

                    widget.state.addActivity(activity);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
