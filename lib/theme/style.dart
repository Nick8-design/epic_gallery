import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LargeTextSize=26.0;
const MediumTextSize=20.0;
const BodyTextSize=16.0;


const String FontNameDefault = "Montserrat";
const String Salsa = "Salsa";

final AppBarTextStyle= GoogleFonts.salsa(
    fontWeight: FontWeight.w300,
    fontSize: MediumTextSize,
    color: Colors.white
);

final TitleStyle= GoogleFonts.salsa(

    fontWeight: FontWeight.w300,
    fontSize: LargeTextSize,
    color: Colors.black
);

const Body1TextSyle= TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w300,
    fontSize: BodyTextSize,
    color: Colors.black
);