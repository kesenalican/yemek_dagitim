import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<Dio>((ref) {
  //var baseUrl = ref.watch(currentInfoProvider);
  return Dio(BaseOptions(baseUrl: 'http://84.51.60.24:5240/'));
});
