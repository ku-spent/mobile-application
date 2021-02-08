import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final bool hasSeeMore;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const Section({
    Key key,
    @required this.title,
    @required this.child,
    this.hasSeeMore = true,
    this.margin = const EdgeInsets.only(bottom: 12.0),
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
  }) : super(key: key);

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.kanit(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          this.hasSeeMore
              ? InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'ดูเพิ่มเติม',
                        style: GoogleFonts.kanit(color: Theme.of(context).primaryColor.withOpacity(0.9)),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      margin: margin,
      padding: padding,
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          child,
        ],
      ),
    );
  }
}
