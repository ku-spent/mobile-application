// import 'package:flutter/material.dart';
// import 'package:spent/domain/model/News.dart';

// class WebViewBottom extends StatefulWidget {
//   final News news;

//   WebViewBottom({Key key, @required this.news}) : super(key: key);

//   @override
//   _WebViewBottomState createState() => _WebViewBottomState();
// }

// class _WebViewBottomState extends State<WebViewBottom> {
//   News _news;
//   bool _isBookmarked = false;
//   String _likeStatus = NewsAction.noneLike;

//   @override
//   void initState() {
//     super.initState();
//     _news = widget.news;
//   }

//   void _onClickLike() {
//     setState(() {
//       _likeStatus = _likeStatus == NewsAction.like ? NewsAction.noneLike : NewsAction.like;
//     });
//   }

//   void _onClickDislike() {
//     setState(() {
//       _likeStatus = _likeStatus == NewsAction.dislike ? NewsAction.noneLike : NewsAction.dislike;
//     });
//   }

//   void _onClickBookmark() {
//     setState(() {
//       _isBookmarked = !_isBookmarked;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget _buildIcon({Function onPressed, Icon inActive, Icon active, bool isActive}) {
//       return IconButton(
//         color: isActive ? Theme.of(context).primaryColor : Colors.grey,
//         onPressed: onPressed,
//         icon: isActive ? active : inActive,
//       );
//     }

//     return BottomAppBar(
//       child: Container(
//         decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: Theme.of(context).dividerColor))),
//         height: 48.0,
//         child: Padding(
//           padding: EdgeInsets.only(left: 32, right: 32),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildIcon(
//                 isActive: _likeStatus == NewsAction.like,
//                 active: Icon(Icons.thumb_up),
//                 inActive: Icon(Icons.thumb_up_outlined),
//                 onPressed: _onClickLike,
//               ),
//               Container(
//                 width: 28,
//               ),
//               _buildIcon(
//                 isActive: _likeStatus == NewsAction.dislike,
//                 active: Icon(Icons.thumb_down),
//                 inActive: Icon(Icons.thumb_down_outlined),
//                 onPressed: _onClickDislike,
//               ),
//               Container(
//                 width: 28,
//               ),
//               _buildIcon(
//                 isActive: _isBookmarked,
//                 active: Icon(Icons.bookmark),
//                 inActive: Icon(Icons.bookmark_outline),
//                 onPressed: _onClickBookmark,
//               ),
//               Container(
//                 width: 28,
//               ),
//               IconButton(
//                 icon: Icon(Icons.share),
//                 onPressed: () => {},
//                 color: Colors.grey,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
