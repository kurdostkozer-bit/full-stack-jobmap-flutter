import 'package:flutter/material.dart';
import '../../spacing/app_spacing.dart';
import '../../radius/app_radius.dart';

/// Custom Text Field with validation and styling
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? maxLength;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final bool showCounter;

  const AppTextField({
    Key? key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.validator,
    this.showCounter = false,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? GestureDetector(
                    onTap: () => setState(() => _obscureText = !_obscureText),
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  )
                : widget.suffixIcon,
            counterText: widget.showCounter ? null : '',
            filled: true,
            fillColor: _focusNode.hasFocus
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: hasError
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
        ),
      ],
    );
  }

  /// Email field variant
  factory AppTextField.email({
    Key? key,
    String? label,
    String? hintText,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Email',
      hintText: hintText ?? 'Enter your email',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      prefixIcon: const Icon(Icons.email_outlined),
      onChanged: onChanged,
      validator: validator,
    );
  }

  /// Password field variant
  factory AppTextField.password({
    Key? key,
    String? label,
    String? hintText,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return AppTextField(
      key: key,
      label: label ?? 'Password',
      hintText: hintText ?? 'Enter your password',
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: true,
      prefixIcon: const Icon(Icons.lock_outlined),
      onChanged: onChanged,
      validator: validator,
    );
  }

  /// Search field variant
  factory AppTextField.search({
    Key? key,
    String? hintText,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
  }) {
    return AppTextField(
      key: key,
      hintText: hintText ?? 'Search...',
      controller: controller,
      keyboardType: TextInputType.text,
      prefixIcon: const Icon(Icons.search),
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
