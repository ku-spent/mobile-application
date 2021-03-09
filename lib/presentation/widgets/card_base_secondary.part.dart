part of 'card_base.dart';

extension CardBaseSecondaryMethod on _CardBaseState {
  Widget _buildSecondaryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => _goToQuerySourcePage(),
          child: Container(
            child: Row(
              children: [
                SourceIcon(
                  width: 18.0,
                  height: 18.0,
                  source: _news.source,
                ),
                Container(
                  width: 4.0,
                ),
                Text(
                  _news.source,
                  style: GoogleFonts.kanit(),
                ),
                Container(
                  width: 8.0,
                ),
                Text(
                  timeago.format(_news.pubDate, locale: 'th'),
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
        ClickableIcon(
          active: Icon(Icons.more_vert),
          inActive: Icon(Icons.more_vert),
          onPressed: _settingModalBottomSheet,
        ),
      ],
    );
  }

  Widget _buildSecondaryContent() {
    return Expanded(
      child: Column(
        children: [
          Text(
            _news.title,
            maxLines: 3,
            style: GoogleFonts.kanit(fontSize: 18.0, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          widget.showSummary && _news.summary.length > 0
              ? Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    _news.summary,
                    style: GoogleFonts.kanit(color: Colors.black.withOpacity(0.7)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildSecondary() {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () => _goToLink(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            _buildSecondaryHeader(),
            Container(
              height: 110.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4.0),
                        _buildSecondaryContent(),
                      ],
                    ),
                  ),
                  Container(width: 24.0),
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: _news.image,
                      placeholder: (context, url) => Container(color: Colors.black26),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 140.0,
                      height: 110.0,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ],
              ),
            ),
            widget.showBottom ? _buildBottom() : Container(height: 8.0),
          ],
        ),
      ),
    );
  }
}
