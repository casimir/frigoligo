extension HumanizedStringExtension on DateTime {
  String toHumanizedString() {
    final now = DateTime.now();
    final diff = now.difference(this);
    String stringed;
    if (diff.inDays.abs() > 0) {
      stringed = '${diff.inDays.abs()} days';
    } else if (diff.inHours.abs() > 0) {
      stringed = '${diff.inHours.abs()} hours';
    } else if (diff.inMinutes.abs() > 0) {
      stringed = '${diff.inMinutes.abs()} minutes';
    } else {
      stringed = '${diff.inSeconds.abs()} seconds';
    }
    return diff.isNegative ? 'in $stringed' : '$stringed ago';
  }
}
