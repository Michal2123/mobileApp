mixin SufixAgeHelper {
  String ageCheck(int? age) {
    if (age != null && age < 25) {
      if (age > 21) {
        age = int.parse(age.toString().substring(1));
      }
      if (age == 1) {
        return '$age rok';
      } else if (age > 1 && age < 5) {
        return '$age lata';
      }
      return '$age lat';
    }
    return '';
  }
}
