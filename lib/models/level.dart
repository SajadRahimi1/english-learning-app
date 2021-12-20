extension Level on int {
  String level() {
    int input = this;
    if (input < 901) return "Level 1";
    if (input < 1500) return "Level 2";
    if (input < 3000) return "Level 3";
    if (input < 5400) return "Level 4";
    if (input < 8400) return "Level 5";
    if (input > 8400) return "Level 6";
    return "";
  }

  int levelNumber() {
    int input = this;
    if (input < 901) return 1;
    if (input < 1500) return 2;
    if (input < 3000) return 3;
    if (input < 5400) return 4;
    if (input < 8400) return 5;
    if (input > 8400) return 6;
    return 0;
  }
}

extension Timer on int {
  String formatSecond() {
    Duration duration = Duration(seconds: this);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension StringToDuration on String {
  Duration toDuration() {
    String input = this;
    List times = input.split(':');
    return Duration(
        hours: int.parse(times[0]),
        minutes: int.parse(times[1]),
        seconds: int.parse(times[2]));
  }
}

extension Percent on int {
  double levelPercent() {
    int input = this;
    if (input < 901) return (input / 900) / 3 * 2;
    if (input < 1500) return (input / 1500) / 3 * 2;
    if (input < 3000) return (input / 3000) / 3 * 2;
    if (input < 5400) return (input / 5400) / 3 * 2;
    if (input < 8400) return (input / 8400) / 3 * 2;
    if (input < 16201) return (input / 16200) / 3 * 2;
    return 1;
  }
}

extension Current on int {
  String showCurrent() {
    int input = this;
    if (input < 901) return "15 / ${((input / 3 * 2) / 60).round()}";
    if (input < 1500) return "25 / ${((input / 3 * 2) / 60).round()}";
    if (input < 3000) return "50 / ${((input / 3 * 2) / 60).round()}";
    if (input < 5400) return "85 / ${((input / 3 * 2) / 60).round()}";
    if (input < 8400) return "140 / ${((input / 3 * 2) / 60).round()}";
    if (input > 8400) return "270 / ${((input / 3 * 2) / 60).round()}";
    return "";
  }
}
