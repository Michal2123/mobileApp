mixin MessageViewHelper {
  String messageDateParser(String date) {
    if (date.isNotEmpty) {
      var tempDateInMin =
          DateTime.now().difference(DateTime.parse(date)).inMinutes;
      var tempDateInHrs =
          DateTime.now().difference(DateTime.parse(date)).inHours;
      if (tempDateInMin < 60) {
        return '${DateTime.now().difference(DateTime.parse(date)).inMinutes.toString()} min';
      } else if (tempDateInHrs < 24) {
        return '${DateTime.now().difference(DateTime.parse(date)).inHours.toString()} godz';
      }

      return '${DateTime.now().difference(DateTime.parse(date)).inDays.toString()} dni';
    }
    return date;
  }
}
