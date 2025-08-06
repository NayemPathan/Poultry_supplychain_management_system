import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:poultry_supply_chain_app/features/customer/screens/my_orders_screen.dart';
import 'package:poultry_supply_chain_app/features/customer/screens/payment_info_screen.dart';
import 'package:poultry_supply_chain_app/features/customer/screens/place_order_screen.dart';
import 'package:poultry_supply_chain_app/features/employee/screens/delivery_orders_ui.dart';
import 'package:poultry_supply_chain_app/features/employee/screens/employee_profile_schedule_screen.dart';
import 'package:poultry_supply_chain_app/features/employee/screens/mark_payment_received_screen.dart';
import 'package:poultry_supply_chain_app/features/employee/screens/pickup_orders_ui.dart';
import 'package:poultry_supply_chain_app/features/employee/screens/view_assigned_orders_screen.dart';
import 'package:poultry_supply_chain_app/features/farmer/screens/chat_inquiry_screen.dart';
import 'package:poultry_supply_chain_app/features/farmer/screens/create_farm_stock_screen.dart';
import 'package:poultry_supply_chain_app/features/farmer/screens/owner_orders_screen.dart';
import 'package:poultry_supply_chain_app/features/farmer/screens/update_farm_stock_screen.dart';
import 'package:poultry_supply_chain_app/features/farmer/screens/view_linked_businesses_screen.dart';
import 'package:poultry_supply_chain_app/features/owner/screens/business_management_screen.dart';
import 'package:provider/provider.dart';
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';
import 'package:poultry_supply_chain_app/auth/auth_screen.dart';
import 'package:poultry_supply_chain_app/features/owner/screens/owner_dashboard_screen.dart';
import 'package:poultry_supply_chain_app/features/employee/screens/employee_dashboard_screen.dart';
import 'package:poultry_supply_chain_app/features/farmer/screens/farmer_dashboard_screen.dart';
import 'package:poultry_supply_chain_app/features/customer/screens/customer_dashboard_screen.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/error_display.dart'; // You'll create this

class AppRouter {
   static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          // This route will check auth status and redirect
          final authProvider = Provider.of<AuthProvider>(context);
          if (authProvider.status == AuthStatus.authenticated) {
            // Redirect to appropriate dashboard based on role
            final role = authProvider.userRole;
            if (role == 'OWNER') return const OwnerDashboardScreen();
            if (role == 'EMPLOYEE') return const EmployeeDashboardScreen();
            if (role == 'FARMER') return const FarmerDashboardScreen();
            if (role == 'CUSTOMER') return const CustomerDashboardScreen();
            return const ErrorDisplay(message: 'Unknown Role'); // Fallback for unknown role
          } else if (authProvider.status == AuthStatus.unauthenticated) {
            return const AuthScreen();
          }
          // Show a loading screen while checking auth status
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      // Role-based dashboards
      GoRoute(
        path: '/dashboard/:role',
        builder: (context, state) {
          final role = state.pathParameters['role'];
          switch (role) {
            case 'OWNER':
              return const OwnerDashboardScreen();
            case 'EMPLOYEE':
              return const EmployeeDashboardScreen();
            case 'FARMER':
              return const FarmerDashboardScreen();
            case 'CUSTOMER':
              return const CustomerDashboardScreen();
            default:
              return const ErrorDisplay(message: 'Dashboard not found for this role.');
          }
        },
      ),
      // Owner Management Routes (Placeholder for now)
      GoRoute(
        path: '/owner/business-management',
        builder: (context, state) => const PlaceholderScreen(title: 'Business Management'), // Use the actual screen
      ),
      GoRoute(
        path: '/owner/staff-management',
        builder: (context, state) => const PlaceholderScreen(title: 'Staff Management'),
      ),
      GoRoute(
        path: '/owner/customer-management',
        builder: (context, state) => const PlaceholderScreen(title: 'Customer Management'),
      ),
      GoRoute(
        path: '/owner/farmer-management',
        builder: (context, state) => const PlaceholderScreen(title: 'Farmer Management'),
      ),
      GoRoute(
        path: '/owner/orders-collections',
        builder: (context, state) => const PlaceholderScreen(title: 'Orders & Collections'),
      ),
      GoRoute(
        path: '/owner/billing-reports',
        builder: (context, state) => const PlaceholderScreen(title: 'Billing & Reports'),
      ),
      GoRoute(
        path: '/customer/place-order',
        builder: (context, state) => const PlaceOrderScreen(),
      ),
      GoRoute(
        path: '/customer/my-orders',
        builder: (context, state) => const MyOrdersScreen(),
      ),
      GoRoute(
        path: '/customer/payment-info',
        builder: (context, state) => const PaymentInfoScreen(),
      ),
      GoRoute(
        path: '/farmer/dashboard',
        builder: (context, state) => const FarmerDashboardScreen(),
      ),
      GoRoute(
        path: '/farmer/create-stock',
        builder: (context, state) => const CreateFarmStockScreen(),
      ),
      GoRoute(
        path: '/farmer/update-stock',
        builder: (context, state) => const UpdateFarmStockScreen(),
      ),
      GoRoute(
        path: '/farmer/view-businesses',
        builder: (context, state) => const ViewLinkedBusinessesScreen(),
      ),
      GoRoute(
        path: '/farmer/owner-orders',
        builder: (context, state) => const OwnerOrdersScreen(),
      ),
      GoRoute(
        path: '/farmer/chat-inquiry',
        builder: (context, state) => const ChatInquiryScreen(),
      ),
      GoRoute(
        path: '/employee/assigned-orders',
        builder: (context, state) => const ViewAssignedOrdersScreen(),
      ),
      GoRoute(
        path: '/employee/pickup-orders',
        builder: (context, state) => const PickupOrdersUI(),
      ),
      GoRoute(
        path: '/employee/delivery-orders',
        builder: (context, state) => const DeliveryOrdersUI(),
      ),
      GoRoute(
        path: '/employee/mark-payment',
        builder: (context, state) => const MarkPaymentReceivedScreen(),
      ),
      GoRoute(
        path: '/employee/profile-schedule',
        builder: (context, state) => const EmployeeProfileScheduleScreen(),
      ),
      // Add other specific routes here as you build out features
      // Example:
      // GoRoute(
      //   path: '/owner/business-management',
      //   builder: (context, state) => const BusinessManagementScreen(),
      // ),
      // GoRoute(
      //   path: '/customer/place-order',
      //   builder: (context, state) => const PlaceOrderPage(),
      // ),
    ],
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final loggedIn = authProvider.status == AuthStatus.authenticated;
      final loggingIn = state.matchedLocation == '/login';

      // If not logged in and not on the login page, redirect to login
      if (!loggedIn && !loggingIn) {
        return '/login';
      }
      // If logged in and on the login page, redirect to dashboard
      if (loggedIn && loggingIn) {
        final role = authProvider.userRole;
        if (role != null) {
          return '/dashboard/$role';
        }
        return '/dashboard/unknown'; // Fallback
      }
      // No redirect needed
      return null;
    },
    errorBuilder: (context, state) => ErrorDisplay(message: state.error.toString()),
  );
}
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Text('This is the $title screen. Content coming soon.'),
      ),
    );
  }
}