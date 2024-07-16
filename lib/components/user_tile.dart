import 'package:flutter/material.dart';

import '../models/message.dart';

class UserTile extends StatelessWidget{
  final Users users;
  final void Function()? onTap;

  const UserTile({
      required this.users,
      required this.onTap,
  });

  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical:5),
        padding: EdgeInsets.all(4),
        child: Row(
          children:[
            Padding(
              padding: EdgeInsets.all(20),
              child: Stack(
                children:[
                  Icon(Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                  ),
                  if(users.hasUnreadMessages)
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(users.email,)
          ],
        ),
      ),
    );
  }
  
}