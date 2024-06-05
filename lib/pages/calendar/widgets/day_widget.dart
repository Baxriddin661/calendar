
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../caledar_bloc/change_period_bloc.dart';
import 'add_note_widget.dart';
import 'month_widget.dart';

class DayWidget extends StatelessWidget {
  DayWidget(
      {Key? key,
      required this.day,
      required this.week,
      required this.year,
      required this.month})
      : super(key: key);
  final String day;
  final String week;
  final String year;
  final String month;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChangePeriodBloc>(context);

    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    'Day',
                    fontWeight: FontWeight.w500,
                    size: 18,
                  ),
                  const Spacer(),
                  AppText(
                    month,
                    fontWeight: FontWeight.w500,
                    size: 18,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            var lastDayOfMonth = getDaysInMonth(
                                int.parse(year), monthNameToNumber(month)!);

                            if (int.parse(day) == 1) {
                              var monthNumber = monthNameToNumber(month)!;
                              bloc.add(MonthPeriodEvent(
                                  month: monthNumberToName(monthNumber - 1)));

                              lastDayOfMonth = getDaysInMonth(int.parse(year),
                                  monthNameToNumber(month)! - 1);

                              bloc.add(DayPeriodEvent(day: '$lastDayOfMonth'));
                            } else {
                              bloc.add(
                                  DayPeriodEvent(day: '${int.parse(day) - 1}'));
                            }
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greyWhite,
                          ),
                          color: AppColors.grey,
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            var lastDayOfMonth = getDaysInMonth(
                                int.parse(year), monthNameToNumber(month)!);

                            if (int.parse(day) >= lastDayOfMonth) {
                              var monthNumber = monthNameToNumber(month)!;
                              bloc.add(MonthPeriodEvent(
                                  month: monthNumberToName(monthNumber + 1)));
                              bloc.add(DayPeriodEvent(day: '1'));
                            } else {
                              bloc.add(
                                  DayPeriodEvent(day: '${int.parse(day) + 1}'));
                            }
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greyWhite,
                          ),
                          color: AppColors.grey,
                          icon: const Icon(Icons.arrow_forward_ios_rounded))
                    ],
                  )
                ],
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: AppText(
            day,
            size: 55,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        AddEventWidget(month: month, year: year, day: day, week: week)
      ],
    );
  }
}

int getDaysInMonth(
  int year,
  int month,
) {
  if (month < 1 || month > 12) {
    throw ArgumentError('Month must be between 1 and 12');
  }

  if (month == 12) {
    return 31;
  }

  // Calculate the number of days in the given month
  var nextMonth = DateTime(year, month + 1, 1);
  var lastDayOfMonth = nextMonth.subtract(Duration(days: 1)).day;

  return lastDayOfMonth;
}
