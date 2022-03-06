import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/series_details_presenter/series_details_presenter.dart';
import '../shared/components/image_widget.dart';
import 'components/seasons_info_widget.dart';
import 'components/series_details_content.dart';
import 'components/series_details_sliding_app_bar.dart';

import '../../../domain/entities/get_series_details/series_detailed_info_entity.dart';
import '../../../domain/entities/list_all_series/series_basic_info_entity.dart';
import '../../themes/app_colors.dart';

class SeriesDetailsPage extends StatefulWidget {
  final SeriesDetailsPresenter presenter;
  const SeriesDetailsPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<SeriesDetailsPage> createState() => _SeriesDetailsPageState();
}

class _SeriesDetailsPageState extends State<SeriesDetailsPage> {
  SeriesBasicInfoEntity? seriesInfo;
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();
    seriesInfo = getNavigationArguments(argumentKey: 'seriesInfo');

    widget.presenter.getSeriesDetails(
      seriesId: seriesInfo != null ? seriesInfo!.id : '',
    );
  }

  T? getNavigationArguments<T>({required String argumentKey}) {
    if (Get.arguments != null && Get.arguments[argumentKey] != null) {
      return Get.arguments[argumentKey] as T;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      extendBodyBehindAppBar: true,
      appBar: SeriesDetailsSlidingAppBar(scrollController: controller),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.grey,
            automaticallyImplyLeading: false,
            elevation: 0,
            stretch: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground
                ],
                background: seriesInfo != null
                    ? Hero(
                        tag: seriesInfo!.id,
                        child: ImageWidget(
                            imageNetworkPath: seriesInfo!.image.original),
                      )
                    : const SizedBox()),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            StreamBuilder<SeriesDetailedInfoEntity?>(
                stream: widget.presenter.seriesDetailsStream,
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasData && streamSnapshot.data != null) {
                    return Column(
                      children: [
                        SeriesDetailsContent(
                          seriesDetails: streamSnapshot.data!,
                        ),
                        SeasonsInfoWidget(
                            seasons: streamSnapshot.data!.seasons),
                      ],
                    );
                  } else if (streamSnapshot.hasError) {
                    return const Padding(
                      padding: EdgeInsets.all(64),
                      child: Center(
                        child: Text('Something Wrong Happened'),
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(64),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })
          ])),
        ],
      ),
    );
  }
}
