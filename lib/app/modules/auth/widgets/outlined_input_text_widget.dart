import 'package:flutter/material.dart';
import '../../../common/dimens/dimens.dart';

class OutlinedInputTextFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool? readOnly;
  final TextInputType? inputType;
  final VoidCallback? onTap;
  final TextEditingController editingController;

  const OutlinedInputTextFieldWidget(
      {super.key,
      this.hintText,
      required this.editingController,
      this.labelText,
      this.inputType,
      this.errorText,
      this.onTap,
      this.readOnly});

  @override
  State<OutlinedInputTextFieldWidget> createState() =>
      _OutlinedInputTextFieldWidgetState();
}

class _OutlinedInputTextFieldWidgetState
    extends State<OutlinedInputTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly ?? false,
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
