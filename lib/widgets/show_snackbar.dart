import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

showCustomSnackBar({required String message, required ContentType ctype}) {
  return SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    // behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: (ctype == ContentType.failure)
          ? 'Oh Snap!'
          : (ctype == ContentType.help)
              ? 'Hello There!'
              : (ctype == ContentType.success)
                  ? 'Successful!'
                  : 'Warning!',
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ctype,
    ),
  );
}
