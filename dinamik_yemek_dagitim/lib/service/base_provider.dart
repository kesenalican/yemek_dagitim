import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = FutureProvider<Dio>((ref) async {
  //var baseUrl = ref.watch(currentInfoProvider);
  return Dio(BaseOptions(baseUrl: 'http://84.51.60.24:5240/'));
});
