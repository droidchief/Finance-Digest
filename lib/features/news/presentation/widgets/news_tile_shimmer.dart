import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';

class NewsTileShimmer extends StatelessWidget {
  const NewsTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(0.3),
      highlightColor: AppColors.white.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              color: AppColors.black,
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 12, width: 80, color: AppColors.black),
                  const Gap(20),
                  Container(height: 20, width: double.infinity, color: AppColors.black),
                  const Gap(6),
                  Container(height: 20, width: double.infinity, color: AppColors.black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
