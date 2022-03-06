import 'package:flutter/material.dart';
import 'package:flutter_tv_maze_jobsity/src/domain/entities/core/episode_entity.dart';
import 'package:flutter_tv_maze_jobsity/src/routes/app_routes.dart';
import 'package:flutter_tv_maze_jobsity/src/ui/pages/shared/components/image_widget.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeEntity episode;
  const EpisodeCard({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.episodeDetailsPage,
            arguments: {'episode': episode},
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: AppColors.grey1,
                ),
                child: Hero(
                  tag: '${episode.id}${episode.name}',
                  child: ImageWidget(imageNetworkPath: episode.image.medium),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Flexible(
              child: Text(
                'S${episode.seasonNumber}E${episode.number} ${episode.name}',
                style: Theme.of(context).textTheme.headline2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
