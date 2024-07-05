import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MYTextFidls extends StatefulWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController Controller;
  final FocusNode? focusNode;

  MYTextFidls(
      {super.key,
      required this.hintText, // Required placeholder text
      required this.obscure, // Required boolean to obscure text
      required this.Controller, // Required text controller
      this.focusNode});

  @override
  State<MYTextFidls> createState() => _MYTextFidlsState();
}

class _MYTextFidlsState extends State<MYTextFidls> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          obscureText: widget.obscure,
          controller: widget.Controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey.shade400,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ));
  }
}
