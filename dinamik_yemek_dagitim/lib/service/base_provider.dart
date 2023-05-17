import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<Dio>((ref) {
  //var baseUrl = ref.watch(currentInfoProvider);
  return Dio(BaseOptions(baseUrl: 'http://192.168.1.22:5240/'));
});
