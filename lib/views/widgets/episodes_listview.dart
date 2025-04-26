import 'package:flutter/material.dart';
import 'package:rickandmorty/models/episode_model.dart';

class EpisodesListview extends StatefulWidget {
  final List<EpisodeModel> episodes;
  final bool loadMore;
  final VoidCallback? onLoadMore;
  const EpisodesListview({
    super.key,
    required this.episodes,
    this.onLoadMore,
    this.loadMore = false,
  });

  @override
  State<EpisodesListview> createState() => _EpisodesListviewState();
}

class _EpisodesListviewState extends State<EpisodesListview> {
  final _scroolController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listenScroll();
  }

  void _listenScroll() {
    _scroolController.addListener(() {
      final maxScroll = _scroolController.position.maxScrollExtent;
      final currentPositon = _scroolController.position.pixels;
      final delta = 200;

      if (maxScroll - currentPositon <= delta) {
        widget.onLoadMore?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scroolController,
      padding: EdgeInsets.zero,
      itemCount: widget.episodes.length,
      itemBuilder: (context, index) {
        final EpisodeModel model = widget.episodes[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.face_retouching_natural, size: 36),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                model.episode,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                model.name,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            if (widget.loadMore && index == widget.episodes.length - 1)
              CircularProgressIndicator.adaptive(),
          ],
        );
      },
      separatorBuilder:
          (context, index) => Divider(
            color: Theme.of(context).colorScheme.tertiary,
            indent: 30,
            endIndent: 30,
            height: 0,
          ),
    );
  }
}
