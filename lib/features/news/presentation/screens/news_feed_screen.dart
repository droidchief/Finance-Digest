import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../bloc/news_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/primary_button.dart';
import '../../data/models/news_model.dart';
import '../widgets/news_tile.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  void initState() {
    context.read<NewsBloc>().add(FetchNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: AppColors.black,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.midnightBlue,
        title: GestureDetector(
          onTap: () {
            context.read<NewsBloc>().add(FetchNews());
          },
          child: Text(
            "Hey {first_name}",
            style: TextStyle(
              fontSize: 32,
              height: 1.25,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: AppColors.midnightBlue,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is FetchNewsSuccess) {
                  final news = state.news;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: news?.length ?? 0,
                    itemBuilder: (context, index) {
                      final newsItem = news?[index];
                      return newsItem != null
                          ? NewsTile(newsModel: newsItem)
                          : SizedBox.shrink();
                    },
                  );
                }
                if (state is FetchNewsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is FetchNewsError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.25,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          PrimaryButton(
                            width: 120,
                            onPressed: () {
                              context.read<NewsBloc>().add(FetchNews());
                            },
                              text: "Retry",
                          )
                        ],
                      ),
                    ),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
