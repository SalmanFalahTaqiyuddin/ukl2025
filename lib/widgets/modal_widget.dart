import 'package:flutter/material.dart';

class ModalWidget {
  showFullModal(context, Widget isi) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Pustaka",
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: Color(0xFF1A2D25)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Pustaka",
              style: TextStyle(
                color: Color(0xFF1A2D25),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
          ),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xfff8f8f8), width: 1),
              ),
            ),
            child: isi,
          ),
        );
      },
    );
  }
}
