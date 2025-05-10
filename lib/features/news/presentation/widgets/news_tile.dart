import 'package:fin_hub/core/theme/app_colors.dart';
import 'package:fin_hub/features/news/data/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class NewsTile extends StatelessWidget {
  final NewsModel newsItem;

  const NewsTile({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.black,
              image: newsItem.image != null
                  ? DecorationImage(
                image: NetworkImage(newsItem.image!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      newsItem.source != null
                          ? newsItem.source!.toUpperCase()
                          : "Unverified source",
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Date",
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  newsItem.headline ?? "",
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}