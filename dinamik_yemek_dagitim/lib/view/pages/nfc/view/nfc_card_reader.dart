import 'dart:typed_data';

import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcCardReader extends StatefulWidget {
  const NfcCardReader({super.key});

  @override
  State<NfcCardReader> createState() => _NfcCardReaderState();
}

class _NfcCardReaderState extends State<NfcCardReader> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
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
                      //! NFC ile bilgi aldığım kısım

                      // Flexible(
                      //   flex: 2,
                      //   child: Container(
                      //     margin: const EdgeInsets.all(4),
                      //     constraints: const BoxConstraints.expand(),
                      //     decoration: BoxDecoration(border: Border.all()),
                      //     child: SingleChildScrollView(
                      //       child: ValueListenableBuilder<dynamic>(
                      //         valueListenable: result,
                      //         builder: (context, value, child) =>
                      //             Text('${value ?? ''}'),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: context.dynamicHeight / 1.4,
                        left: context.dynamicWidth / 3.2,
                        child: SizedBox(
                          height: context.dynamicHeight * 0.5,
                          width: context.dynamicWidth * 0.8,
                          child: Flexible(
                            flex: 3,
                            child: GridView.count(
                              padding: const EdgeInsets.all(4),
                              crossAxisCount: 2,
                              childAspectRatio: 4,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: LightColor.orange,
                                    ),
                                    onPressed: _tagRead,
                                    child: const Text('Bas ve Okut')),
                                // ElevatedButton(
                                //     child: Text('Ndef Write'), onPressed: _ndefWrite),
                                // ElevatedButton(
                                //     child: Text('Ndef Write Lock'),
                                //     onPressed: _ndefWriteLock),
                              ],
                            ),
                          ),
                        ),
                      ),
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
