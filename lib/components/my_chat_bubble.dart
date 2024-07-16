import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const MyChatBubble({
    required this.message,
    required this.isCurrentUser,
  });

  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context,listen:false ).isDarkMode;
    
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 2.5, horizontal:25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isCurrentUser
        ? (isCurrentUser ? Colors.green.shade600 :  Colors.green.shade600) 
        : (isCurrentUser ? Colors.grey.shade900 : Colors.grey.shade900)    
      ),

      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser ? Colors.white : (isDarkMode ? Colors. white : Colors.black)
        ),
      ),
    );
  }
}
