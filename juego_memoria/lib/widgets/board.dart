import 'package:flutter/material.dart';

Widget board(String title, String info, TextStyle textStyle) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(20.00),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          // ignore: use_full_hex_values_for_flutter_colors
          color: const Color(0xffacb80ff), borderRadius: BorderRadius.circular(13)),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold,fontFamily: 'Silk'),
          ),
          const SizedBox(height: 10),
          Text(
            info,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
