import 'package:flutter/material.dart';

/// TextField design
class Input extends StatefulWidget {
  ////// Creates a new instance of [Input].
  const Input({
    Key? key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.value,
    this.hint,
  }) : super(key: key);

  /// label of the input
  final String label;

  /// hint of the input
  final String? hint;

  /// if there was a previous value
  final String? value;

  /// controller for TextFormField
  final TextEditingController controller;

  /// focus node for TextFormField
  final FocusNode focusNode;
  @override
  State<Input> createState() => InputState();
}

/// so that we can initialize a unique global key from form.dart
class InputState extends State<Input> {
  /// error message
  String? error;

  /// animation switcher
  bool isFocused = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 1000),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 1,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween<double>(
                          begin: isFocused ? 12 : 17,
                          end: isFocused ? 20 : 17,
                        ),
                        builder: (_, size, __) {
                          return Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: size,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                      if (error != null)
                        const SizedBox(
                          width: 10,
                        ),
                      if (error != null)
                        Expanded(
                          child: Text(
                            error!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: isFocused
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              cursorColor: Colors.purple,
                              cursorWidth: 3,
                              controller: widget.controller,
                              focusNode: widget.focusNode,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.controller.text.isNotEmpty
                                      ? widget.controller.text
                                      : widget.value ?? widget.hint ?? '--',
                                  style: TextStyle(
                                    fontSize: widget.controller.text.isNotEmpty
                                        ? 20.0
                                        : widget.hint != null
                                            ? 15
                                            : 20.0,
                                    color: widget.controller.text.isNotEmpty
                                        ? Colors.black
                                        : widget.hint != null
                                            ? Colors.grey
                                            : Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () async {
        setState(() => isFocused = !isFocused);
        if (isFocused == true) {
          widget.focusNode.requestFocus();
        }
        if (isFocused == false) {
          widget.focusNode.unfocus();
        }
      },
    );
  }

  /// update focus using widget key
  void removeFocus() {
    setState(() => isFocused = false);
  }

  ///update error using widget key
  void updateError(String? err) {
    setState(() => error = err);
  }
}
