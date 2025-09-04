import 'package:book_cart/utils/login.dart';
import 'package:book_cart/widgets/font_provider.dart';
import 'package:flutter/material.dart';
import './screens/main_screen.dart';
import 'screens/shopping_cart.dart';
import 'package:provider/provider.dart';
import './widgets/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences
      .getInstance(); // Ensure that SharedPreferences is initialized before runApp

  final token = await getToken();
  if (token != null) {
    scheduleLogoutBasedOnToken(token);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => FontSizeProvider()..loadFontSize()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;
    print(fontSize);
    
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: fontSize.toDouble()),
          bodyMedium: TextStyle(fontSize: fontSize.toDouble() + 2),
          bodyLarge: TextStyle(fontSize: fontSize.toDouble() + 4),
        ),
      ),
      // theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/cart': (context) => const ShoppingCartPage(),
      },
    );
  }
}
