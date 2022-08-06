import 'package:bloc_finals_exam/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app_router.dart';
import 'app_themes.dart';
import 'screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBlocOverrides.runZoned(
      () => runApp(
        MyApp(appRouter: AppRouter()),
      ),
      storage: storage,
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, state) {
          return MaterialApp(
            title: 'BloC Tasks App',
            theme: AppThemes.appThemeData[state],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

class ThemeCubit extends HydratedCubit<AppTheme> {
  ThemeCubit() : super(AppTheme.lightMode);

  void toggle() => emit(
      state == AppTheme.lightMode ? AppTheme.darkMode : AppTheme.lightMode);

  @override
  AppTheme fromJson(Map<String, dynamic> json) => AppTheme.values.firstWhere(
      (e) =>
          describeEnum(e).toUpperCase() ==
          json['value'].toString().toUpperCase(),
      orElse: () => AppTheme.lightMode);

  @override
  Map<String, dynamic> toJson(AppTheme state) =>
      {'value': describeEnum(state).toUpperCase()};
}
