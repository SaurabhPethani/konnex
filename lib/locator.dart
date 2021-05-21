import 'index.dart';

GetIt locator = GetIt.instance;

void setupModelLocator() async {
  locator.registerSingleton(TaskModel());
  locator.registerSingleton(IndividualModel());
  locator.registerSingleton(AssignmentModel());
  locator.registerSingleton(SqliteDatabaseService());
}

void setupServiceLocator() async {}
