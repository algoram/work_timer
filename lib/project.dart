class Project {
  final String name;
  final Stopwatch stopwatch;
  final Duration alreadyElapsed;

  Project(this.name, this.stopwatch, this.alreadyElapsed);

  String getTotalElapsedTime() {
    Duration temp = stopwatch.elapsed + alreadyElapsed;

    final int hours = temp.inHours;
    final int minutes = temp.inMinutes % 60;
    final int seconds = temp.inSeconds % 60;

    final String minString = minutes < 10 ? '0$minutes' : '$minutes';
    final String secString = seconds < 10 ? '0$seconds' : '$seconds';

    return '$hours:$minString:$secString';
  }

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        alreadyElapsed = Duration(seconds: json['elapsed']),
        stopwatch = Stopwatch();

  Map<String, dynamic> toJson() =>
      {'name': name, 'elapsed': (alreadyElapsed + stopwatch.elapsed).inSeconds};
}
