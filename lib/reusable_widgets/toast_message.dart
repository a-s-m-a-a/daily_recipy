import 'package:daily_recipy/utils/toast_message_status.dart';
import 'package:flutter/material.dart';

class ToastMessageWidget extends StatelessWidget {
  final ToastMessageStatus toastMessageStatus;
  final String message;
  const ToastMessageWidget(
      {this.toastMessageStatus = ToastMessageStatus.normal,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5),
                color: Colors.black12,
              )
            ],
            borderRadius: BorderRadius.circular(15),
            color: toastMessageStatus == ToastMessageStatus.success
                ? Colors.green
                : toastMessageStatus == ToastMessageStatus.faild
                    ? Colors.red
                    : Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                      color: toastMessageStatus == ToastMessageStatus.normal
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
