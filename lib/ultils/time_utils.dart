class TimeUtils {
  static String hourFormatter(int hour, int minute) {
    return '${_addLeadingZero(hour)}:${_addLeadingZero(minute)}';
  }

  static String _addLeadingZero(int number) {
    return (number < 10 ? '0' : '') + number.toString();
  }
}
