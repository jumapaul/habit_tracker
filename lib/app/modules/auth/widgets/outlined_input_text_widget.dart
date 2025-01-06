import 'package:flutter/material.dart';
import '../../../common/dimens/dimens.dart';

class InputTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? errorText;
  final TextInputType? inputType;
  final TextEditingController editingController;

  const InputTextFieldWidget(
      {super.key,
      required this.hintText,
      required this.editingController,
      this.labelText,
      this.inputType,
      this.errorText});

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      controller: widget.editingController,
      decoration: InputDecoration(
        errorText: widget.errorText,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: AppTextStyles.subHeaderStyle,
        labelStyle: AppTextStyles.subHeaderStyle,
      ),
      maxLines: 4,
      minLines: 1,
      style: AppTextStyles.subHeaderStyle,
      validator: (val) {
        if (val?.isEmpty == true) {
          return widget.errorText;
        }
        return null;
      },
    );
  }
}
