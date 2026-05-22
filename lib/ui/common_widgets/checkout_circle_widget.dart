import 'package:flutter/material.dart';

class CheckoutCircleWidget extends StatelessWidget {
  const CheckoutCircleWidget({
    super.key,
    this.addressCompleeted,
    this.peymentCompleeted,
    this.summeryCompleeted,
    this.addressSelcted,
    this.peymentSelcted,
    this.summrySelcted,
  });

  final bool? addressCompleeted;
  final bool? summeryCompleeted;
  final bool? peymentCompleeted;

  final bool? addressSelcted;
  final bool? summrySelcted;
  final bool? peymentSelcted;

  @override
  Widget build(BuildContext context) {
    final bool addr = addressCompleeted ?? false;
    final bool summ = summeryCompleeted ?? false;
    final bool pay = peymentCompleeted ?? false;

    final bool addrSel = addressSelcted ?? false;
    final bool summSel = summrySelcted ?? false;
    final bool paySel = peymentSelcted ?? false;

    const Color activeColor = Color(0xFF22C55E);
    const Color selectedColor = Color(0xFF6C47FF);
    const Color inactiveColor = Color(0xFFE5E7EB);
    const Color inactiveText = Color(0xFFADB5BD);

  
    Widget stepItem({
      required String label,
      required String number,
      required bool isCompleted,
      required bool isSelected,
    }) {
      final Color circleColor = isCompleted
          ? activeColor
          : isSelected
              ? selectedColor
              : inactiveColor;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
              border: (!isCompleted && !isSelected)
                  ? Border.all(color: const Color(0xFFD1D5DB), width: 1.5)
                  : null,
            
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check_rounded, size: 15, color: Colors.white)
                  : Text(
                      number,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? Colors.white : inactiveText,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: (isCompleted || isSelected)
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: isCompleted
                  ? activeColor
                  : isSelected
                      ? selectedColor
                      : inactiveText,
              letterSpacing: 0.3,
            ),
          ),
        ],
      );
    }

  
   
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: stepItem(
              label: 'Address',
              number: '1',
              isCompleted: addr,
              isSelected: addrSel,
            ),
          ),
       Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: addr ? activeColor : inactiveColor,
            ),
          ),
        ),
      ),
          Expanded(
            child: stepItem(
              label: 'Summary',
              number: '2',
              isCompleted: summ,
              isSelected: summSel,
            ),
          ),
        Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: summ ? activeColor : inactiveColor,
            ),
          ),
        ),
      ),
          Expanded(
            child: stepItem(
              label: 'Payment',
              number: '3',
              isCompleted: pay,
              isSelected: paySel,
            ),
          ),
        ],
      ),
    );
  }
}