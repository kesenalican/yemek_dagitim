import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = FutureProvider<Dio>((ref) async {
  //var baseUrl = ref.watch(currentInfoProvider);
  return Dio(BaseOptions(baseUrl: 'http://192.168.1.1/api/'));
});
