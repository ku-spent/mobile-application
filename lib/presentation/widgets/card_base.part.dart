part of 'card_base.dart';

extension CardBaseMethod on _CardBaseState {
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => _goToQuerySourcePage(),
          child: Container(
            padding: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 8),
            child: Row(
              children: [
                SourceIcon(
                  source: _news.source,
                ),
                Container(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _news.source,
                      style: GoogleFonts.kanit(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      timeago.format(_news.pubDate, locale: 'th'),
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag, {bool isCategory = false}) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () => isCategory ? _goToQueryCategoryPage() : goToQueryTagPage(tag),
      child: Text(
        tag,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.kanit(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 4.0, top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: [
                    _news.tags.length > 0 && _news.tags[0] == _news.category
                        ? Container()
                        : _buildTag(_news.category, isCategory: true)
                  ] +
                  _news.tags
                      .sublist(0, 1 > _news.tags.length ? _news.tags.length : 1)
                      .map((tag) => _buildTag(tag))
                      .toList(),
            ),
          ),
          Row(children: [
            _buildIcon(
              isActive: _userAction == UserAction.LIKE,
              active: Icon(Icons.favorite),
              inActive: Icon(Icons.favorite_outline),
              onPressed: _onClickLike,
              activeColor: Colors.red[400],
            ),
            _buildIcon(
              isActive: _isBookmarked,
              active: Icon(Icons.bookmark),
              inActive: Icon(Icons.bookmark_outline),
              onPressed: _onClickBookmark,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildContent(bool showPicture) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () => _goToLink(context),
      child: Column(
        children: [
          showPicture
              ? Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: _news.image,
                      placeholder: (context, url) => Container(color: Colors.black26),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ))
              : Container(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  _news.title,
                  style:
                      widget.isSubCard ? Theme.of(context).textTheme.bodyText2 : Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                widget.showSummary && _news.summary.length > 0
                    ? Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          _news.summary,
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
