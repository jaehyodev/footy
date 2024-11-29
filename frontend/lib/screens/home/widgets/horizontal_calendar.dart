import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart'; // 추가된 패키지
import 'package:provider/provider.dart';
import '../../../providers/date_provider.dart';
import '../themes/horizontal_calendar_style.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  HorizontalCalendarState createState() => HorizontalCalendarState();
}

class HorizontalCalendarState extends State<HorizontalCalendar> {
  late DateTime _currentDate;
  final List<DateTime> _daysInMonth = [];
  final AutoScrollController _controller = AutoScrollController();

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now().toUtc();
    _generateDaysInMonth();
    _scrollToToday();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 현재 달의 날짜 리스트 생성
  void _generateDaysInMonth() {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0);

    _daysInMonth.clear();
    for (int i = 0; i <= lastDayOfMonth.day - 1; i++) {
      _daysInMonth.add(firstDayOfMonth.add(Duration(days: i)));
    }
  }

  // 오늘 날짜를 스크롤 위치로 맞추기
  void _scrollToToday() {
    DateTime today = DateTime.now();
    int todayIndex = _daysInMonth.indexWhere((date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);

    _controller.scrollToIndex(
      todayIndex,
      duration: const Duration(milliseconds: 500),
      preferPosition: AutoScrollPosition.middle,
    );
  }

  // 이전 달로 이동
  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
      _generateDaysInMonth();
    });
  }

  // 이후 달로 이동
  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
      _generateDaysInMonth();
    });
  }

  // 날짜 선택 시
  void _onDateSelected(BuildContext context, DateTime selectedDate) {
    context
        .read<DateProvider>()
        .updateDateTime(selectedDate); // Provider를 통해 상태 업데이트
    print(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // <년도 월> 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: _previousMonth,
            ),
            Text(
              '${_currentDate.year}년 ${_currentDate.month}월',
              style: const TextStyle(color: Colors.black),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: _nextMonth,
            ),
          ],
        ),
        // 요일 및 날짜 버튼
        SizedBox(
          height: 48,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: _daysInMonth.length,
            itemBuilder: (context, index) {
              DateTime date = _daysInMonth[index];
              return AutoScrollTag(
                key: ValueKey(index),
                controller: _controller,
                index: index,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: 40,
                    child: Container(
                      decoration: getButtonDecoration(context, date),
                      child: ElevatedButton(
                        onPressed: () => _onDateSelected(context, date),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.transparent),
                          elevation: 0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              getDayOfWeek(date),
                              style: getTextStyle(context, date),
                            ),
                            Text(
                              '${date.day}',
                              style: getTextStyle(context, date, isBold: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
