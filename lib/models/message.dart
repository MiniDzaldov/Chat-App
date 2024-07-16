import 'package:cloud_firestore/cloud_firestore.dart';

// מחלקת Message
class Message {
  final String senderID; // מזהה המשתמש השולח
  final String senderEmail; // כתובת הדוא"ל של המשתמש השולח
  final String receiverID; // מזהה המשתמש המקבל
  final String message; // תוכן ההודעה
  final Timestamp timestamp; // חותם הזמן של ההודעה
  final bool isRead; // מציין אם ההודעה נקראה או לא

  // בנאי למחלקה
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
    this.isRead = false, // ברירת מחדל: ההודעה לא נקראה
  });

  // המרת ההודעה למפת נתונים
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID, // מזהה המשתמש השולח
      'senderEmail': senderEmail, // כתובת הדוא"ל של המשתמש השולח
      'receiverID': receiverID, // מזהה המשתמש המקבל
      'message': message, // תוכן ההודעה
      'timestamp': timestamp, // חותם הזמן של ההודעה
      'isRead': isRead, // מציין אם ההודעה נקראה או לא
    };
  }

  // המרת מפת נתונים לאובייקט הודעה
  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      senderID: map['senderID'], // מזהה המשתמש השולח
      senderEmail: map['senderEmail'], // כתובת הדוא"ל של המשתמש השולח
      receiverID: map['receiverID'], // מזהה המשתמש המקבל
      message: map['message'], // תוכן ההודעה
      timestamp: map['timestamp'], // חותם הזמן של ההודעה
      isRead: map['isRead'] ?? false, // מציין אם ההודעה נקראה או לא (ברירת מחדל: לא נקראה)
    );
  }
}

// מחלקת Users
class Users {
  String uid; // מזהה המשתמש
  String email; // כתובת הדוא"ל של המשתמש
  bool hasUnreadMessages; // מציין אם יש למשתמש הודעות לא נקראות

  // בנאי למחלקה
  Users({
    required this.uid,
    required this.email,
    this.hasUnreadMessages = false, // ברירת מחדל: אין הודעות לא נקראות
  });

  // המרת המשתמש למפת נתונים
  Map<String, dynamic> toMap() {
    return {
      'uid': uid, // מזהה המשתמש
      'email': email, // כתובת הדוא"ל של המשתמש
      'hasUnreadMessages': hasUnreadMessages, // מציין אם יש למשתמש הודעות לא נקראות
    };
  }

  // המרת מפת נתונים לאובייקט משתמש
  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'], // מזהה המשתמש
      email: map['email'], // כתובת הדוא"ל של המשתמש
      hasUnreadMessages: map['hasUnreadMessages'] ?? false, // מציין אם יש למשתמש הודעות לא נקראות (ברירת מחדל: אין הודעות לא נקראות)
    );
  }
}