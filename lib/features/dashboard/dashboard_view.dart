import 'package:berana/features/dashboard/dashboard_viewmodel.dart';
import 'package:berana/features/resource_detail/resource_detail_view.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: BaseColors.quaternaryBerana,
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Image.asset('assets/bg/bezier_bg.png'),
                  Column(
                    children: [
                      DashboardViewHeader(viewModel: viewModel),
                      SizedBox(height: 50),
                      SizedBox(
                        height: 250,
                        child: ScrollSnapList(
                          itemBuilder: (BuildContext context, int index) {
                            return ResourceCard(
                                viewModel: viewModel,
                                index: index,
                                primaryText: 'Audio Book ${index + 1}',
                                secondaryText: 'Author ${index + 1}',
                                imagePath: 'assets/cover_art/book_cover_$index.png',
                            );
                          },
                          itemCount: 3,
                          itemSize: 100,
                          onItemFocus: (index) {},
                          dynamicItemSize: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                'Recently Opened Books',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return ResourceCard(
                                  viewModel: viewModel,
                                  index: index,
                                  width: 120,
                                  height: 150,
                                  primaryText: 'Audio Book ${index + 1}',
                                  secondaryText: 'Author ${index + 1}',
                                  imagePath: 'assets/cover_art/book_cover_$index.png',
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ]
              ),
            ),
          );
        });
  }
}

class DashboardViewHeader extends StatelessWidget {
  DashboardViewHeader({required this.viewModel});
  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Our Top Picks',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
              ),
              ProfilePicture(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
          child: Text('PFP')
      )
    );
  }
}

class DashboardViewHeaderCarousel extends StatefulWidget {
  final List<Widget> carouselItems;
  DashboardViewHeaderCarousel({required this.carouselItems});
  @override
  State<DashboardViewHeaderCarousel> createState() => _DashboardViewHeaderCarouselState();
}

class _DashboardViewHeaderCarouselState extends State<DashboardViewHeaderCarousel> {
  int indexInView = 0;
  void setIndexInView (int index) {
    if(index < 0 || index > widget.carouselItems.length - 1) return;
    setState(() {
      indexInView = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ...widget.carouselItems.map((item) {
          return GestureDetector(
            onTap: () {
              setIndexInView(widget.carouselItems.indexOf(item));
            },
            child: Container(
              width: indexInView == widget.carouselItems.indexOf(item) ? 100 : 50,
              height: indexInView == widget.carouselItems.indexOf(item) ? 100 : 50,
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: indexInView == widget.carouselItems.indexOf(item) ? Colors.white : Colors.grey,
              ),
              child: Center(
                  child: Text(widget.carouselItems.indexOf(item).toString())
              ),
            ),
          );
        })
      ],
    );
  }
}

class ResourceCard extends StatelessWidget {
  final DashboardViewModel viewModel;

  final int index;
  final double width;
  final double height;
  final String imagePath;
  final String primaryText;
  final String secondaryText;
  ResourceCard(
      {
        required this.viewModel,
        required this.index,
        this.imagePath = '',
        this.width = 175,
        this.height = 350,
        required this.primaryText,
        this.secondaryText = ''
      }
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.navigationService.navigateTo(
          ResourceDetailView(
            index: index,
          )
        );
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          elevation: 12,
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                () {
                  if(imagePath.isNotEmpty) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                          imagePath,
                          height: height * 0.6,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                } (),

                Text(
                  "AudioBook ${index + 1}",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),

                () {
                  if(secondaryText.isNotEmpty) {
                    return Text(
                      secondaryText,
                      style: const TextStyle(
                          fontSize: 12,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                } ()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
