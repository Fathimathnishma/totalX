
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtestapp/features/home/data/i_mainfacade.dart';
import 'package:totalxtestapp/features/home/presentation/provider/provider.dart';
import 'package:totalxtestapp/features/home/presentation/view/home_screen.dart';

import 'package:totalxtestapp/general/di/injection.dart';

var height;
var width;

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
 await configureDependancy();

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainProvider(sl<IMainfacade>()
        )),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
