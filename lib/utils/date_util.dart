class DateUtil{
  static var _monthsNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static String getFormattedDate(int dueDate) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dueDate);
    return "${_monthsNames[date.month - 1]}  ${date.day.toString().padLeft(2, '0')}";
  }
}
