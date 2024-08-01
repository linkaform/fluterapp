extension StringExtension on String {
  String limitLength(int maxLength) => length <= maxLength
      ? this
      : '${substring(0, maxLength)}...';
}