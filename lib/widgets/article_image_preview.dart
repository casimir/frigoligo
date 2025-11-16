import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/services/local/storage/database/models/article.drift.dart';

class ArticleImagePreview extends StatelessWidget {
  const ArticleImagePreview({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child:
          // https://github.com/Baseflow/flutter_cached_network_image/issues/383
          article.previewPicture!.endsWith('.svg')
              ? SvgPicture.network(article.previewPicture!, fit: BoxFit.cover)
              : CachedNetworkImage(
                imageUrl: article.previewPicture!,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
    );
  }
}
