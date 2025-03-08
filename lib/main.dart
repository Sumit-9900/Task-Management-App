import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/theme/app_theme.dart';
import 'package:task_management_app/core/widgets/loader.dart';
import 'package:task_management_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_management_app/features/auth/presentation/pages/signin_page.dart';
import 'package:task_management_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/presentation/cubit/priority_cubit.dart';
import 'package:task_management_app/features/task/presentation/pages/task_screen.dart';
import 'package:task_management_app/firebase_options.dart';
import 'package:task_management_app/init_dependencies.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<PriorityCubit>()),
        BlocProvider(create: (_) => getIt<TaskBloc>()..add(TaskFetched())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      themeMode: ThemeMode.light,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (snapshot.hasData && snapshot.data != null) {
            return const TaskScreen();
          }
          return SigninPage();
        },
      ),
    );
  }
}
