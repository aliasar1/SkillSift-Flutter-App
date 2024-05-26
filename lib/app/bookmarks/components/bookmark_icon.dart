import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';
import 'package:skillsift_flutter_app/core/models/job_model.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkIcon extends StatefulWidget {
  final Job job;
  final BookmarkController bookmarkController;

  const BookmarkIcon({
    Key? key,
    required this.job,
    required this.bookmarkController,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookmarkIconState createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _getBookmarkStatus();
  }

  void _getBookmarkStatus() async {
    if (mounted) {
      bool bmStatus =
          await widget.bookmarkController.getBookmarkStatus(widget.job.id);
      setState(() {
        isBookmarked = bmStatus;
      });
    }
  }

  void _toggleBookmarkStatus() async {
    widget.bookmarkController.toggleBookmarkStatus(widget.job);
    if (mounted) {
      setState(() {
        isBookmarked = !isBookmarked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toggleBookmarkStatus(),
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: LightTheme.primaryColor,
      ),
    );
  }
}
