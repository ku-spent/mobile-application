import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoResult extends StatelessWidget {
  final String imageUrl = "assets/images/noresult.svg";
  const NoResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: MediaQuery.of(context).size.height / 4.5),
          SvgPicture.asset(
            imageUrl,
          ),
          Container(height: 16.0),
          Text("ไม่พบผลลัพธ์", style: GoogleFonts.kanit(fontWeight: FontWeight.w400, fontSize: 18.0))
          // Text("We can't find any")
        ],
      ),
    );
  }
}
