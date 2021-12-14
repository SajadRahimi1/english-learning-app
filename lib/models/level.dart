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
