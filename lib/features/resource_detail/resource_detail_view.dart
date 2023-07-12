import 'package:berana/features/audio_video_player/audio_video_player_view.dart';
import 'package:berana/features/resource_detail/resource_detail_viewmodel.dart';
import 'package:berana/layouts/root_layout/root_layout.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ResourceDetailView extends StatelessWidget {
  final int index;
  ResourceDetailView({required this.index});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResourceDetailViewModel>.reactive(
        viewModelBuilder: () => ResourceDetailViewModel(),
        builder: (context, viewModel, child) {
            return RootLayout(
                backgroundColor: BaseColors.quaternaryBerana,
                child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                children: [
                  Image.asset('assets/bg/bezier_bg.png'),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ResourceDetailViewHeader(viewModel: viewModel),
                        SizedBox(height: 20),
                        ResourceDetailViewImage(
                            imagePath: 'assets/cover_art/book_cover_$index.png'
                        ),
                        SizedBox(height: 5),
                        ResourceDetailViewInfoRow(
                          title: 'Audio Book ${index + 1}',
                          author: 'Author ${index + 1}',
                          narrator: 'Narrator ${index + 1}',
                          price: '150 ETB',
                          duration: '1h 30min',
                        ),
                        SizedBox(height: 60),
                        ResourceDetailViewActionRow(viewModel: viewModel,),
                        SizedBox(height: 10),
                        ResourceDetailViewSynopsis(),
                      ],
                    ),
                  ),
                ]
              )
            )
          );
        });
  }
}

class ResourceDetailViewHeader extends StatelessWidget {
  final ResourceDetailViewModel viewModel;
  ResourceDetailViewHeader({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: GestureDetector(
                  onTap: () => viewModel.navigationService.pop(),
                  child: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ResourceDetailViewImage extends StatelessWidget {
  final String imagePath;
  ResourceDetailViewImage({required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      height: 400,
    );
  }
}

class ResourceDetailViewInfoRow extends StatelessWidget {
  final String title;
  final String author;
  final String narrator;
  final String duration;
  final String price;

  ResourceDetailViewInfoRow({
    required this.title,
    required this.author,
    required this.narrator,
    required this.duration,
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    textAlign: TextAlign.start,
                  ),
              ),
              SizedBox(height: 2),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                    author,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                    textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 2),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                    'Narrated by $narrator',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                    textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 2),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                    duration,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                    textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Center(
              child: Text(
                price,
                style: TextStyle(
                  color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              )
          )
        ],
      )
    );
  }

}

class ResourceDetailViewActionRow extends StatelessWidget {
  final ResourceDetailViewModel viewModel;
  ResourceDetailViewActionRow({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: BaseColors.primaryBerana,
            width: 1
          )
        )
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ResourceDetailViewButton(index: 0, onPressed: () {}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResourceDetailViewButton(index: 1, onPressed: () {}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ResourceDetailViewButton(index: 2, onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return SampleVideoPlayer();
                    });
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResourceDetailViewButton extends StatelessWidget {
  final Function onPressed;
  final int index;
  ResourceDetailViewButton({required this.onPressed, required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.33,
        child: Column(
          children: [
            () {
              if(index == 0) {
                return Column(
                  children: [
                    Icon(Icons.favorite_outline),
                    Text('Save')
                  ],
                );
              } else if (index == 1) {
                return Column(
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    Text('Add to Cart')
                  ],
                );
              } else {
                return Column(
                  children: [
                    Icon(Icons.play_arrow_outlined),
                    Text('Sample')
                  ],
                );
              }
            } ()
          ],
        ),
      ),
    );
  }
}

class ResourceDetailViewSynopsis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            'SYNOPSIS',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 1),
        Container(
          child: Text(
              """It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
              """,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 14
              ),
          ),
        ),
      ],
    );
  }

}

class SampleVideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Image.asset('assets/sample_audiobook.png', fit: BoxFit.fill,)
    );
  }

}