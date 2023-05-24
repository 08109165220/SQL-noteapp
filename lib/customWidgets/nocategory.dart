import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Nocategorybubble extends StatelessWidget {
  const Nocategorybubble({Key? key,  this.categoryName="No category", this.onTap}) : super(key: key);
final String? categoryName;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFF1A1A1A),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: 10,),
            Icon(Icons.folder_outlined,color: Colors.white,size:19,),
            SizedBox(width: 4,),
            Flexible(child: Text(categoryName! ,style: GoogleFonts.roboto(fontSize: 15,color: Colors.white60,fontWeight: FontWeight.w400),)),
            SizedBox(width: 1,),
            Icon(Icons.arrow_drop_down_sharp,color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}
