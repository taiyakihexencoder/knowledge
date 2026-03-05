import 'package:flutter/material.dart';

/// TextEditingControllerを外から渡す場合に
/// 直接作成してしまうと、メモリリークするため、
/// このWidgetから生成する.
class TextEditingControllerProvider extends StatefulWidget {
  TextEditingControllerProvider({
    super.key,
    int controllerCount = 1,
    required Function(BuildContext, List<TextEditingController>) builder,
  }):
    _controllers = List.generate(controllerCount, (_) => TextEditingController()),
    _builder = builder;


  final List<TextEditingController> _controllers;
  final Function(BuildContext, List<TextEditingController>) _builder;

  @override
  TextEditingControllerProviderState createState() {
    return TextEditingControllerProviderState();
  }
}

class TextEditingControllerProviderState extends State<TextEditingControllerProvider> {
  @override
  void dispose() {
    for (TextEditingController controller in widget._controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(context, widget._controllers);
  }
}
