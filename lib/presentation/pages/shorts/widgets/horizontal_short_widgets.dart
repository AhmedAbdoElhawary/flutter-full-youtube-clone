part of 'shorts_page_view.dart';

/// below and bov

class _HorizontalButtons extends StatelessWidget {
  const _HorizontalButtons(this.videoDetailsItem, {Key? key}) : super(key: key);
  final VideoDetailsItem videoDetailsItem;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      end: 0,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 15.0, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _LikeDisLikeButtons(videoDetailsItem),
            const _CommentButton(),
            fiveSpace,
            const _CommentCount(),
            space,
            const _ShareButton(),
            fiveSpace,
            const _ShareText(),
            space,
            CustomNetworkDisplay(
              imageUrl: videoDetailsItem.getChannelProfileImageUrl(),
              height: 40,
              width: 40,
            ),
            // twentyFiveSpace,
          ],
        ),
      ),
    );
  }

  Widget get space => const SizedBox(height: 25);
  Widget get fiveSpace => const SizedBox(height: 5);

  Widget get twentyFiveSpace => const SizedBox(height: 15);
}

class _LikeDisLikeButtons extends StatefulWidget {
  const _LikeDisLikeButtons(this.videoDetailsItem);
  final VideoDetailsItem videoDetailsItem;

  @override
  State<_LikeDisLikeButtons> createState() => _LikeDisLikeButtonsState();
}

class _LikeDisLikeButtonsState extends State<_LikeDisLikeButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const _LikeButton(),
        fiveSpace,
        _NumberOfLikes(widget.videoDetailsItem),
        space,
        const _DisLikeButton(),
        fiveSpace,
        const _DisLikeText(),
        space,
      ],
    );
  }

  Widget get space => const SizedBox(height: 25);

  Widget get fiveSpace => const SizedBox(height: 5);
}

class _LikeButton extends StatefulWidget {
  const _LikeButton();

  @override
  State<_LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<_LikeButton> {
  bool isVideoLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.thumb_up_alt_rounded,
        color: isVideoLiked ? BaseColorManager.blue : BaseColorManager.white,
        size: 32,
      ),
      onTap: () {
        setState(() {
          isVideoLiked = !isVideoLiked;
        });
      },
    );
  }
}

class _NumberOfLikes extends StatelessWidget {
  const _NumberOfLikes(this.videoDetailsItem);
  final VideoDetailsItem videoDetailsItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          videoDetailsItem.getVideoLikesCount(),
          style: getNormalStyle(color: BaseColorManager.white),
        ),
      ),
    );
  }
}

class _DisLikeButton extends StatefulWidget {
  const _DisLikeButton();

  @override
  State<_DisLikeButton> createState() => _DisLikeButtonState();
}

class _DisLikeButtonState extends State<_DisLikeButton> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Icon(
        Icons.thumb_down_alt_rounded,
        color: isClicked ? BaseColorManager.blue : BaseColorManager.white,
        size: 32,
      ),
    );
  }
}

class _DisLikeText extends StatelessWidget {
  const _DisLikeText();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "Dislike",
          style: getNormalStyle(color: BaseColorManager.white, fontSize: 12),
        ),
      ),
    );
  }
}

class _CommentButton extends StatelessWidget {
  const _CommentButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Icon(
        Icons.insert_comment_rounded,
        color: BaseColorManager.white,
        size: 32,
      ),
    );
  }
}

class _CommentCount extends StatelessWidget {
  const _CommentCount();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "243",
          style: getNormalStyle(color: BaseColorManager.white, fontSize: 12),
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Icon(
        Icons.share,
        color: BaseColorManager.white,
        size: 32,
      ),
    );
  }
}

class _ShareText extends StatelessWidget {
  const _ShareText();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "Share",
          style: getNormalStyle(color: BaseColorManager.white, fontSize: 12),
        ),
      ),
    );
  }
}
