class Individual {
  String name;
  double knowledge = 0,
      understanding = 0,
      specialize = 0,
      efficiency = 0,
      overall = 0,
      timelyCompletion = 0,
      taskUndertaken = 0,
      noOfHrsPrac = 0,
      taskCompleted = 0;
  int tpw = 0;
  int perfectMatch = 0;
  Individual(
      {this.name,
      this.knowledge,
      this.understanding,
      this.specialize,
      this.efficiency,
      this.overall,
      this.timelyCompletion,
      this.taskUndertaken,
      this.taskCompleted,
      this.noOfHrsPrac,
      this.perfectMatch,
      this.tpw});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'knowledge': knowledge.toString(),
      'understanding': understanding.toString(),
      'specialize': specialize.toString(),
      'efficiency': efficiency.toString(),
      'overall': overall.toString(),
      'timelyCompl': timelyCompletion.toString(),
      'taskUndertaken': taskUndertaken.toString(),
      'taskCompleted': taskCompleted.toString(),
      'noOfHrs': noOfHrsPrac.toString(),
      'tpw': tpw.toString()
    };
  }

  factory Individual.fromMap(Map<String, dynamic> indi) => Individual(
        name: indi['name'],
        knowledge: double.parse(indi['knowledge']),
        understanding: double.parse(indi['understanding']),
        specialize: double.parse(indi['specialize']),
        efficiency: double.parse(indi['efficiency']),
        overall: double.parse(indi['overall']),
        timelyCompletion: double.parse(indi['timelyCompl']),
        taskUndertaken: double.parse(indi['taskUndertaken']),
        taskCompleted: double.parse(indi['taskCompleted']),
        noOfHrsPrac: double.parse(indi['noOfHrs']),
        tpw: int.parse(indi['tpw']),
      );
}
