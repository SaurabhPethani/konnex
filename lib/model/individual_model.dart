import 'package:Konnex/index.dart';
import 'individual.dart';

class IndividualModel extends ChangeNotifier {
  List<Individual> individual = new List<Individual>();

  List<Individual> get individuals => this.individual;

  void setIndividual(List<Individual> indi) {
    individual = indi;
    notifyListeners();
  }

  void deleteIndividual(Individual indi) {
    individual.remove(indi);
    notifyListeners();
  }

  Individual getIndividualByName(String name) {
    return individual.firstWhere((indi) => indi.name == name,
        orElse: () => Individual());
  }

  void addIndividual(Individual i) {
    individual.add(i);
    notifyListeners();
  }

  void growAsPerRating(
      double rating, Individual indi, Task task, int noOfDays) {
    double actual = rating * (task.eta / 5);
    double expected = noOfDays * (indi.tpw / 7);
    indi.efficiency = ((actual / expected) * 100) % 10;
    indi.timelyCompletion = indi.efficiency / 10;

    if (actual >= expected) {
      if (indi.overall < task.level) {
        if (indi.overall < 5) {
          indi.knowledge += indi.knowledge * 0.07;
          indi.understanding += indi.understanding * 0.07;
          indi.specialize += indi.specialize * 0.07;
        } else {
          indi.knowledge += indi.knowledge * 0.04;
          indi.understanding += indi.understanding * 0.04;
          indi.specialize += indi.specialize * 0.04;
        }
      } else if (indi.overall == task.level) {
        if (indi.overall < 5) {
          indi.knowledge += indi.knowledge * 0.06;
          indi.understanding += indi.understanding * 0.06;
          indi.specialize += indi.specialize * 0.06;
        } else {
          indi.knowledge += indi.knowledge * 0.03;
          indi.understanding += indi.understanding * 0.03;
          indi.specialize += indi.specialize * 0.03;
        }
      } else if (indi.overall > task.level) {
        if (indi.overall < 5) {
          indi.knowledge += indi.knowledge * 0.05;
          indi.understanding += indi.understanding * 0.05;
          indi.specialize += indi.specialize * 0.05;
        } else {
          indi.knowledge += indi.knowledge * 0.02;
          indi.understanding += indi.understanding * 0.02;
          indi.specialize += indi.specialize * 0.02;
        }
      }
    } else if (actual < expected) {
      if (indi.overall < task.level) {
        if (indi.overall < 5) {
          indi.knowledge += indi.knowledge * 0.04;
          indi.understanding += indi.understanding * 0.04;
          indi.specialize += indi.specialize * 0.04;
        } else {
          indi.knowledge += indi.knowledge * 0.02;
          indi.understanding += indi.understanding * 0.02;
          indi.specialize += indi.specialize * 0.02;
        }
      } else if (indi.overall == task.level) {
        if (indi.overall < 5) {
          indi.knowledge += indi.knowledge * 0.03;
          indi.understanding += indi.understanding * 0.03;
          indi.specialize += indi.specialize * 0.03;
        } else {
          indi.knowledge += indi.knowledge * 0.015;
          indi.understanding += indi.understanding * 0.015;
          indi.specialize += indi.specialize * 0.015;
        }
      } else if (indi.overall > task.level) {
        if (indi.overall < 5) {
          indi.knowledge += indi.knowledge * 0.025;
          indi.understanding += indi.understanding * 0.025;
          indi.specialize += indi.specialize * 0.025;
        } else {
          indi.knowledge += indi.knowledge * 0.01;
          indi.understanding += indi.understanding * 0.01;
          indi.specialize += indi.specialize * 0.01;
        }
      }
    }

    locator<SqliteDatabaseService>().insertIndividual(indi);
    individual.remove(indi);
    individual.add(indi);
    notifyListeners();
  }
}
