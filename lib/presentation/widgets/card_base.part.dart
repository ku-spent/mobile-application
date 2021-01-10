part of 'card_base.dart';

extension CardBaseMethod on _CardBaseState {
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => _goToQuerySourcePage(context),
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
        _buildIcon(
          isActive: _isBookmarked,
          active: Icon(Icons.bookmark),
          inActive: Icon(Icons.bookmark_outline),
          onPressed: _onClickBookmark,
        ),
      ],
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                _buildIcon(
                  isActive: _userAction == UserAction.LIKE,
                  active: Icon(Icons.favorite),
                  inActive: Icon(Icons.favorite_outline),
                  onPressed: _onClickLike,
                ),
              ]),
              InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () => _goToQueryCategoryPage(context),
                child: Text(
                  '#' + _news.category,
                  style: GoogleFonts.kanit(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
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
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(8),
                    child: Hero(
                        tag: 'news-image-${_news.id}',
                        child: CachedNetworkImage(
                          imageUrl: _news.image,
                          placeholder: (context, url) => Container(color: Colors.black26),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ))
              : Container(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Text(
                  _news.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  _news.summary,
                  style: Theme.of(context).textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
