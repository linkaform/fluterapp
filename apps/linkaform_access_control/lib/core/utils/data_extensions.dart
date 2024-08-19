extension StringExtension on String {
  String limitLength(int maxLength) =>
      length <= maxLength
          ? this
          : '${substring(0, maxLength)}...';
}

extension DateTimeFormatter on String {


  String toCustomHourFormat() {
    DateTime dateTime = DateTime.parse(this);

    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;
    return '$hour:$minute:$second horas';
  }


  String toCustomDateFormat() {
    DateTime dateTime = DateTime.parse(this);
    String day = _getDayName(dateTime.weekday);
    String month = _getMonthName(dateTime.month);
    int year = dateTime.year;
    return '$day ${dateTime.day} de $month del $year';
  }


  String toCustomStartDateFormat() {
    DateTime dateTime = DateTime.parse(this);
    int day = dateTime.day;
    String month = _getMonthName(dateTime.month);
    int year = dateTime.year;
    return '$day De $month del $year';
  }


  String _getDayName(int dayNumber) {
    const days = <String>[
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];
    return days[dayNumber - 1];
  }


  String _getMonthName(int monthNumber) {
    const  months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return months[monthNumber - 1];
  }
}