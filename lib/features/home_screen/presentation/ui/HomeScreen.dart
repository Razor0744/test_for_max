import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_for_max/features/home_screen/presentation/bloc/HomeUiState.dart';
import 'package:test_for_max/features/home_screen/presentation/bloc/HomeBloc.dart';
import 'package:test_for_max/features/home_screen/presentation/ui/CategoryTitle.dart';
import 'package:test_for_max/features/home_screen/presentation/ui/ScheduleText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().getPicturesUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeUiState>(
        builder: (context, state) {
          if (state is Loaded) {
            return SafeArea(
              top: true,
              bottom: true,
              child: ListView(
                children: [
                  const ScheduleText(),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.homeState.animeSeriesList.length,
                      separatorBuilder: (context, index) {
                        return const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0));
                      },
                      itemBuilder: (context, index) {
                        final item = state.homeState.animeSeriesList[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            item.pictureUrl,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 180,
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      var category =
                          state.homeState.kinopoiskCategoryList[index];
                      var categoryList =
                          state.homeState.kinopoiskSeriesList[index];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CategoryTitle(title: category),
                          SizedBox(
                            height: 180,
                            child: ListView.separated(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryList.length,
                              separatorBuilder: (context, index) {
                                return const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0));
                              },
                              itemBuilder: (context, index) {
                                final item = categoryList[index];

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    item.url,
                                    fit: BoxFit.fill,
                                    width: 120,
                                    height: 180,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const Text('error');
        },
      ),
    );
  }
}
