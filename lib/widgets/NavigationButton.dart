import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap; // 新增
  final IconData icon;

  const NavigationButton({
    super.key,
    required this.label,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFDFDFDF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 5,
                children: [
                  Icon(icon, size: 15),
                  SizedBox(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top:-22.5,
            left: 0,
            right: 0,
            child: Image(
              image: AssetImage("assets/images/cat.png"),
              width: 38,
              height: 38,
            ),
          ),
        ],
      ),
    );
  }
}
