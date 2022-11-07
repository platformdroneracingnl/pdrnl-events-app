import 'package:flutter/material.dart';

// My package imports
import 'package:pdrnl_events_app/utils/constants.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key? key,
    required this.menuText,
    required this.menuIcon,
    this.hasNavigation = true,
    required this.press,
  }) : super(key: key);

  final IconData menuIcon;
  final String menuText;
  final bool hasNavigation;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F6F9),
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: press,
        child: Row(
          children: <Widget>[
            Icon(
              menuIcon,
              color: Styles.primaryColor,
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                menuText,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            if (hasNavigation)
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
