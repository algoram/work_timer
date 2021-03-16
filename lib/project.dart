class Project {
  final String name;
  final Stopwatch stopwatch;
  final Duration alreadyElapsed;

  Project(this.name, this.stopwatch, this.alreadyElapsed);

  String getStringRepresentation() {
    Duration temp = alreadyElapsed + stopwatch.elapsed;

    final int hours = temp.inHours;
    final int minutes = temp.inMinutes % 60;
    final int seconds = temp.inSeconds % 60;

    final String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final String secondsString = seconds < 10 ? '0$seconds' : '$seconds';

    return '$hours:$minutesString:$secondsString';
  }

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        alreadyElapsed = Duration(seconds: json['elapsed']),
        stopwatch = Stopwatch();

  Map<String, dynamic> toJson() =>
      {'name': name, 'elapsed': (alreadyElapsed + stopwatch.elapsed).inSeconds};
}
