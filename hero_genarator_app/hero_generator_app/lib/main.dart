import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_generator_app/features/hero_generator/presentation/bloc/hero/hero_event.dart';
import 'injection_container.dart' as di;
import 'features/hero_generator/presentation/bloc/hero/hero_bloc.dart';
import 'features/hero_generator/presentation/bloc/image/image_bloc.dart';
import 'features/hero_generator/presentation/pages/hero_list_page.dart';
import 'features/hero_generator/hero_generator_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HeroBloc>()..add(LoadHeroes())),
        BlocProvider(create: (_) => sl<ImageBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hero Generator',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HeroListPage(),
      ),
    );
  }
}
