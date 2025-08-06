//initial setup//

import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/features/owner/providers/business_management_provider.dart';
import 'package:poultry_supply_chain_app/features/owner/screens/business_management_screen.dart';
import 'package:provider/provider.dart';
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';
import 'package:poultry_supply_chain_app/auth/auth_screen.dart';
import 'package:poultry_supply_chain_app/common/utils/app_router.dart';
import 'package:poultry_supply_chain_app/common/utils/app_theme.dart';
import 'package:poultry_supply_chain_app/features/owner/providers/owner_dashboard_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OwnerDashboardProvider()),
        ChangeNotifierProvider(create: (_) => BusinessManagementProvider())
        // Add other providers here as your app grows
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Poultry Supply Chain App',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router, // Using go_router for routing
      debugShowCheckedModeBanner: false,
    );
  }
}