import 'package:flutter/material.dart';

class PersonNfcMatch extends StatefulWidget {
  const PersonNfcMatch({super.key});

  @override
  State<PersonNfcMatch> createState() => _PersonNfcMatchState();
}

class _PersonNfcMatchState extends State<PersonNfcMatch> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('NFC PAGE'),
    );
  }
}
