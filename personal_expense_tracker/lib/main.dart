import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/provider/transactions_provider.dart';
import 'package:personal_expense_tracker/screens/add_transaction_screen.dart';
import '../firebase_options.dart';
import 'package:personal_expense_tracker/provider/user_provider.dart';
import 'package:personal_expense_tracker/screens/auth_screen.dart';
import 'package:personal_expense_tracker/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TransactionsProvider())
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
      title: 'Personal Expense Traker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.white,
        ),
        useMaterial3: true,
      ),
      routes: {
        AuthScreen.routeName: (_) => const AuthScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        AddTransactionScreen.routeName: (_) => const AddTransactionScreen(),
      },
      initialRoute: Provider.of<UserProvider>(context).user.email != ""
          ? HomeScreen.routeName
          : AuthScreen.routeName,
    );
  }
}
