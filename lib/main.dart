import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transaction_mobile_app/bloc/auth/auth_bloc.dart';
import 'package:transaction_mobile_app/bloc/currency/currency_bloc.dart';
import 'package:transaction_mobile_app/bloc/equb/equb_bloc.dart';
import 'package:transaction_mobile_app/bloc/money_transfer/money_transfer_bloc.dart';
import 'package:transaction_mobile_app/bloc/navigation/navigation_bloc.dart';
import 'package:transaction_mobile_app/bloc/transaction/transaction_bloc.dart';
import 'package:transaction_mobile_app/firebase_options.dart';

import 'bloc/bank_currency_rate/bank_currency_rate_bloc.dart';
import 'config/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51PqWhhRwVC7iqwp5o0W0CYxLvk7p5KGvQM0KPVKQ57PXaaYboFYGOGKax6TKlN5sdzP46iXtsLOGYGCmKHeIJCKn00LfcSwqQO';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Firebase analtics
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  await analytics.setAnalyticsCollectionEnabled(true);
  await analytics.logAppOpen();
  //Firebase Crashlytics
  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  FlutterError.onError = crashlytics.recordFlutterError;

  runApp(
    const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BankCurrencyRateBloc(),
        ),
        BlocProvider(
          create: (context) => EqubBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider(
          create: (context) => MoneyTransferBloc(
            auth: FirebaseAuth.instance,
          ),
        ),
        BlocProvider(
          create: (context) => CurrencyBloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(
            tabController: TabController(length: 5, vsync: this),
          ),
        ),
      ],
      child: ResponsiveApp(
        builder: (_) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouting,
        ),
      ),
    );
  }
}
