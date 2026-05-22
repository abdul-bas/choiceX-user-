
import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/ui/screens/user_dashboard/DashboardScreen.dart';
import 'package:flutter/material.dart';

class OrdersEmptyState extends StatelessWidget {
  const OrdersEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

        
            Container(
              width: 110, height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 48,
                    color: const Color(0xFFE0E3EA),
                  ),
                  Positioned(
                    bottom: 22, right: 20,
                    child: Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        color: barndColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'No active orders',
              style: TextStyle(
                fontSize:   20,
                fontWeight: FontWeight.w800,
                color:      Color(0xFF0D0D0D),
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'You haven\'t placed any orders yet.\nStart shopping to see them here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color:    Color(0xFF9098A3),
                height:   1.65,
              ),
            ),

            const SizedBox(height: 28),

         
            GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => DashboardScreen()),
  (route) => false,
),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 14),
                decoration: BoxDecoration(
                  color:        barndColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color:      barndColor.withOpacity(0.28),
                      blurRadius: 16,
                      offset:     const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Text(
                  'Start Shopping',
                  style: TextStyle(
                    fontSize:   14,
                    fontWeight: FontWeight.w700,
                    color:      Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}