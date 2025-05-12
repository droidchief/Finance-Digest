import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../bloc/news_bloc.dart';
import '../../../../bloc/user_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/primary_button.dart';
import '../widgets/news_tile.dart';
import '../widgets/news_tile_shimmer.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  String fullName = "";


  @override
  void initState() {
    context.read<UserBloc>().add(GetSavedUser());
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
        title: BlocListener<UserBloc, UserState>(
          listener: (BuildContext context, UserState state) {
            if(state is GetSavedUserSuccess) {
              setState(() {
                fullName = "${state.user?.firstName ?? ""} ${state.user?.lastName ?? ""}";
              });
            }
          },
          child: Text(
            "Hey $fullName ",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontSize: 32,
                height: 1.25,
                fontWeight: FontWeight.w900,
                color: AppColors.white,
              ),
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
                  height: 110,
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
                Widget listView;

                if (state is FetchNewsSuccess) {
                  final news = state.news;
                  listView = ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: news?.length ?? 0,
                    itemBuilder: (context, index) {
                      final newsItem = news?[index];
                      return newsItem != null
                          ? NewsTile(newsModel: newsItem)
                          : const SizedBox.shrink();
                    },
                  );
                } else if (state is FetchNewsLoading) {
                  listView = ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 10,
                    itemBuilder: (context, index) => const NewsTileShimmer(),
                  );
                } else if (state is FetchNewsError) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NewsBloc>().add(FetchNews());
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap(20),
                              Text(
                                state.message,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    height: 1,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              PrimaryButton(
                                width: 120,
                                height: 45,
                                onPressed: () {
                                  context.read<NewsBloc>().add(FetchNews());
                                },
                                text: "Retry",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  listView = const SizedBox.shrink();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<NewsBloc>().add(FetchNews());
                  },
                  child: listView,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
