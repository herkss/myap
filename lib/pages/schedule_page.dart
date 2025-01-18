import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Box _scheduleBox = Hive.box('schedules');
  final TextEditingController _controller = TextEditingController();

  /// 스케줄 추가
  void _addSchedule(String date, String content) {
    List schedules = _scheduleBox.get(date, defaultValue: []);
    schedules.add(content);
    _scheduleBox.put(date, schedules);
    setState(() {});
  }

  /// 스케줄 삭제
  void _deleteSchedule(String date, int index) {
    List schedules = _scheduleBox.get(date, defaultValue: []);
    schedules.removeAt(index);
    _scheduleBox.put(date, schedules);
    setState(() {});
  }

  /// 날짜 선택 다이얼로그
  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      _showScheduleDialog(selectedDate);
    }
  }

  /// 스케줄 추가 다이얼로그
  void _showScheduleDialog(DateTime date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Schedule'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter schedule details'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _addSchedule(
                    date.toIso8601String().split('T')[0], _controller.text);
                _controller.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule')),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectDate,
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: _scheduleBox.listenable(),
        builder: (context, Box box, _) {
          List<String> dates = box.keys.cast<String>().toList();
          return ListView.builder(
            itemCount: dates.length,
            itemBuilder: (context, index) {
              String date = dates[index];
              List schedules = box.get(date, defaultValue: []);
              return ExpansionTile(
                title: Text(date),
                children: schedules
                    .asMap()
                    .entries
                    .map(
                      (entry) => ListTile(
                        title: Text(entry.value),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteSchedule(date, entry.key);
                          },
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
