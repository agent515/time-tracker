import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class DurationPicker extends StatelessWidget {
  final onConfirm;
  final Duration totalTime;

  const DurationPicker({
    Key? key,
    required this.totalTime,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Total Time:',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          width: 30.0,
        ),
        GestureDetector(
          onTap: () {
            Picker(
              adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
                const NumberPickerColumn(begin: 0, end: 24, suffix: Text(' H')),
                const NumberPickerColumn(begin: 0, end: 60, suffix: Text(' M')),
                const NumberPickerColumn(begin: 0, end: 60, suffix: Text(' S')),
              ]),
              delimiter: <PickerDelimiter>[
                PickerDelimiter(
                  child: Container(
                    width: 30.0,
                    alignment: Alignment.center,
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ],
              hideHeader: true,
              confirmText: 'OK',
              confirmTextStyle: Theme.of(context).textTheme.bodyText1,
              title: const Text('Select duration'),
              selectedTextStyle: TextStyle(color: Colors.blue),
              onConfirm: onConfirm,
            ).showDialog(context);
          },
          child: Row(
            children: [
              Text(
                '$totalTime'.split('.')[0],
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.lock_clock,
                size: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
