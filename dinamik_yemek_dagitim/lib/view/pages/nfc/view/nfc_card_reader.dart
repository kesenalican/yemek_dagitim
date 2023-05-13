import 'dart:typed_data';

import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/common/dialog_utils.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/model/nfc_model.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/service/nfc_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/viewmodel/nfc_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcCardReader extends ConsumerStatefulWidget {
  const NfcCardReader({super.key});

  @override
  ConsumerState<NfcCardReader> createState() => _NfcCardReaderState();
}

class _NfcCardReaderState extends ConsumerState<NfcCardReader> {
  Location location = Location();
  String latitude = '';
  String longitude = '';
  String gonderilecekLocation = '';
  bool serviceEnabled = false;
  PermissionStatus? permissionGranted;
  LocationData? locationData;
  ValueNotifier<dynamic> result = ValueNotifier(null);
  Future<dynamic> getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    locationData = await location.getLocation();
    latitude = locationData!.latitude.toString();
    longitude = locationData!.longitude.toString();
    gonderilecekLocation = '$latitude, $longitude';
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(nfcViewModel);
    _tagRead();
    getLocation();
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, snapshot) => snapshot.data != true
              ? const Center(
                  child: Text(
                  'Telefonunuzda NFC özelliğini açın!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: LightColor.orange,
                  ),
                ))
              : Stack(
                  children: [
                    OverflowBox(
                      maxWidth: 800,
                      maxHeight: 800,
                      child: Icon(
                        Icons.document_scanner_outlined,
                        size: 400,
                        color: LightColor.orange.withOpacity(0.6),
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       setState(() {});
                    //     },
                    //     icon: const Icon(Icons.read_more_outlined)),
                    // //! NFC ile bilgi aldığım kısım
                    // ValueListenableBuilder<dynamic>(
                    //   valueListenable: result,
                    //   builder: (context, value, child) =>
                    //       Text('${value ?? ''}'),
                    // ),
                    // Positioned(
                    //   top: context.dynamicHeight / 1.4,
                    //   left: context.dynamicWidth / 3.2,
                    //   child: SizedBox(
                    //     height: context.dynamicHeight * 0.5,
                    //     width: context.dynamicWidth * 0.8,
                    //     child: Flexible(
                    //       flex: 3,
                    //       child: GridView.count(
                    //         padding: const EdgeInsets.all(4),
                    //         crossAxisCount: 2,
                    //         childAspectRatio: 4,
                    //         crossAxisSpacing: 4,
                    //         mainAxisSpacing: 4,
                    //         children: [
                    //           ElevatedButton(
                    //               style: ElevatedButton.styleFrom(
                    //                 backgroundColor: LightColor.orange,
                    //               ),
                    //               onPressed: _tagRead,
                    //               child: const Text('Bas ve Okut')),

                    //           // ValueListenableBuilder<dynamic>(
                    //           //   valueListenable: result,
                    //           //   builder: (context, value, child) =>
                    //           //       Text('${value ?? ''}'),
                    //           // ),
                    //           // ElevatedButton(
                    //           //     child: Text('Ndef Write'), onPressed: _ndefWrite),
                    //           // ElevatedButton(
                    //           //     child: Text('Ndef Write Lock'),
                    //           //     onPressed: _ndefWriteLock),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
      setState(() {
        Fluttertoast.showToast(msg: 'KART BAŞARIYLA OKUNDU');
        print(result.value['nfca']['identifier']);
        var bytes = result.value['nfca']['identifier'];
        var serialNumber = bytes
            .map((b) => b.toRadixString(16).padLeft(2, '0'))
            .join(':')
            .toUpperCase();
        ref.watch(nfcReader(NfcModel(
            coordinate: gonderilecekLocation, cardNumber: serialNumber)));
      });
    });
  }

  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Hello World!'),
        NdefRecord.createUri(Uri.parse('https://flutter.dev')),
        NdefRecord.createMime(
            'text/plain', Uint8List.fromList('Hello'.codeUnits)),
        NdefRecord.createExternal(
            'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  void _ndefWriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        result.value = 'Tag is not ndef';
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        result.value = 'Success to "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
}
