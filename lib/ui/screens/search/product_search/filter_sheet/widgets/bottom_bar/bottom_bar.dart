import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/constants/ui_string/variant_color.dart';
import 'package:coice/core/constants/ui_string/variant_storage_opts.dart';
import 'package:coice/state/provider/filter_provider.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/variant_filter_enabled_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Widget buildFilterBottomBar(BuildContext context, List<String> colors,
    List<String> storageCapacity, dynamic products) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, -6),
        ),
      ],
    ),
    padding: EdgeInsets.fromLTRB(
        18, 14, 18, MediaQuery.of(context).padding.bottom + 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
     
        Row(mainAxisSize: MainAxisSize.min,
          children: [
         
            Expanded(
              child: Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find what fits you',
                    style: TextStyle(
                      color: Color(0xFF0F1320),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Apply filters to refine results',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
 
            Consumer<FilterProvider>(builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();

                  final String? selectedColor = value.colorIndex < 0
                      ? null
                      : variantColors[value.colorIndex];

                  final String? selectedStorage = value.storageIndex < 0
                      ? null
                      : variantStorageOpts[value.storageIndex];

                  Map<String, int>? selectedBudget;

                  if (value.budgetRange != null) {
                    selectedBudget = {
                      'min': value.budgetRange!['min'],
                      'max': value.budgetRange!['max'],
                    };
                  }

                  if (value.budgetRange != null ||
                      value.colorIndex >=0 ||
                      value.storageIndex>=0 ) {
                    context.read<ProductSearchController>().setAllVariants(
                          selectedColor,
                          selectedStorage,
                          selectedBudget,
                          products,
                        );

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VariantFilterEnabledScreen(),
                        ));
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                        content: Container(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1D2E),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                          
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B35)
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFFFF6B35)
                                        .withValues(alpha: 0.30),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.filter_alt_outlined,
                                  color: Color(0xFFFF6B35),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),

                            
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'No filter selected',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.1,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Please select at least one filter to continue',
                                      style: TextStyle(
                                        color: Color(0xFF9CA3AF),
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  decoration: BoxDecoration(
                    color: barndColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: barndColor.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Show Results',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.1,
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    ),
  );
}
