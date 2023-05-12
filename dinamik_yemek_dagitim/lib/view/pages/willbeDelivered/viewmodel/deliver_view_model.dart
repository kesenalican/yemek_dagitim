import 'package:dinamik_yemek_dagitim/view/pages/willbeDelivered/model/deliver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliverViewModel extends ChangeNotifier {
  List<DeliverList>? deliverList;
}

final deliverViewModel = ChangeNotifierProvider((ref) => DeliverViewModel());
