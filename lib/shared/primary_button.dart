import 'package:fin_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



enum IconPosition {left, right}

class AppButton extends StatelessWidget {
  final String? text;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  const AppButton(
      {Key? key,
        this.text,
        this.height,
        this.width,
        this.onPressed,

      })
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          FocusScope.of(context).unfocus();
          onPressed!();
        }
      },
      style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith<double>((states) => 0),
        padding: WidgetStateProperty.resolveWith<EdgeInsets>(
              (states) => EdgeInsets.symmetric(vertical: 12),
        ),
        fixedSize: WidgetStateProperty.resolveWith<Size>(
              (states) => Size(width ?? 327, height ?? 48),
        ),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled) || onPressed == null) {
              return AppColors.primary.withOpacity(0.5);
            }
            return AppColors.primary;
          },
        ),
      ),
      child: Text(
        text!,
        style: TextStyle(
          color: AppColors.offWhite
        )

      )
    );
  }
}

