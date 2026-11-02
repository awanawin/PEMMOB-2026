import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class EditProfilSiswaScreen extends StatefulWidget {
  const EditProfilSiswaScreen({super.key});

  @override
  State<EditProfilSiswaScreen> createState() => _EditProfilSiswaScreenState();
}

class _EditProfilSiswaScreenState extends State<EditProfilSiswaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/edit_profil_siswa/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
