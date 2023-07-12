import 'package:auto_size_text/auto_size_text.dart';
import 'package:berana/features/dashboard/dashboard_view.dart';
import 'package:berana/features/genre_selection/genre_selection_viewmodel.dart';
import 'package:berana/features/test/test_view.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GenreSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GenreSelectionViewModel>.reactive(
        viewModelBuilder: () => GenreSelectionViewModel(),
        builder: (context, viewModel, child) {
          return RootLayout(
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/bg/splash_screen_bg.png"),
                            fit: BoxFit.cover),
                      )
                  ),
                  Container(
                    child: Column(
                      children: [
                        GenreSelectionViewHeader(viewModel: viewModel),
                        GenreSelectionFilterTextField(viewModel: viewModel),
                        GenreSelectionViewBody(viewModel: viewModel)
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: BeranaButton(
                            foregroundColor: BaseColors.primaryBerana,
                            backgroundColor: Colors.white,
                            pressedFunc: () {
                              viewModel.navigationService.navigateTo(DashboardView());
                            },
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Continue',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_forward)
                                  ],
                                )
                              ],
                            )
                        )
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ],
              )
          );
        }
    );
  }
}

class GenreSelectionViewHeader extends StatelessWidget {
  final GenreSelectionViewModel viewModel;
  GenreSelectionViewHeader({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: const AutoSizeText(
              'Select at least five genres you like',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class GenreSelectionFilterTextField extends StatelessWidget {
  final GenreSelectionViewModel viewModel;
  GenreSelectionFilterTextField({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextField(
        onChanged: (value) {
          viewModel.searchString.value = value;
        },
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}

class GenreSelectionViewBody extends StatelessWidget {
  final GenreSelectionViewModel viewModel;
  GenreSelectionViewBody({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: GridView.count(
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        children: () {
          List<Widget> widgets = [];
          for (int i = 0; i < viewModel.genreFiltered.length; i++) {
            bool genreIsSelected = viewModel.genreSelected.contains(viewModel.genre[i]);

            widgets.add(
                  Container(
                    child: Center(
                      child: BeranaButton(
                          backgroundColor: genreIsSelected ? BaseColors.primaryBerana : Colors.transparent,
                          pressedFunc: () {
                            if(viewModel.genreSelected.contains(viewModel.genre[i])) {
                              viewModel.removeFromSelectedGenre(viewModel.genre[i]);
                            } else {
                              viewModel.addToGenreSelected(viewModel.genre[i]);
                            }
                          },
                          child: Text(
                              viewModel.genreFiltered[i],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                              textAlign: TextAlign.center
                          )
                      ),
                    ),
                  )
            );
          }
          return widgets;
        } (),
      ),
    );
  }
}