import 'package:dinamik_yemek_dagitim/view/pages/nfc/model/nfc_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NfcViewModel extends ChangeNotifier {}

final nfcViewModel = ChangeNotifierProvider((ref) => NfcViewModel());
