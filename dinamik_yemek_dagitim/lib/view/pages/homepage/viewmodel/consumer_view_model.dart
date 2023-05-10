import 'package:dinamik_yemek_dagitim/view/pages/homepage/model/consumer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsumerViewModel extends ChangeNotifier {
  List<ConsumerListModel>? consumerList; 
  
}

final consumerViewModel = ChangeNotifierProvider((ref) => ConsumerViewModel());
