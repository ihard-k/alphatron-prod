import 'package:flutter/material.dart';

import 'game_const.dart';

const ktButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  fontFamily: kfPortico,
  shadows: [
    Shadow(color: Colors.black, offset: Offset(1, 1)),
  ],
);

const ktAnimatedTextStyle = TextStyle(
  fontFamily: kfPerfograma,
  color: Color(0xFFFF2C29),
  fontSize: 65,
  fontWeight: FontWeight.w900,
);

const ktPorticoLightWhite = TextStyle(
  color: Colors.white,
  fontFamily: 'PorticoLight',
  fontSize: 22,
);

const ktPorticoWhite = TextStyle(
  color: Colors.white,
  fontFamily: 'Portico',
  fontSize: 22,
);

const ktPorticoRedWithShadow = TextStyle(
  color: Colors.red,
  fontFamily: 'Portico',
  fontSize: 18,
  shadows: [
    Shadow(
      color: Color.fromARGB(255, 255, 0, 0),
      blurRadius: 1,
    ),
    Shadow(
      color: Colors.white,
      // color: Color.fromARGB(255, 255, 0, 0),
      blurRadius: 0.2,
    ),
    Shadow(
      color: Color.fromARGB(255, 255, 0, 0),
      blurRadius: 1,
    )
  ],
);

const ktPorticoWhiteWithShadow = TextStyle(
  color: Colors.white,
  fontFamily: 'Portico',
  fontSize: 38,
  shadows: [
    Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 20),
    Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 20),
    Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 20)
  ],
);

const ktPorticoWhiteWithBlackShadow = TextStyle(
  color: Colors.white,
  fontFamily: 'Portico',
  fontSize: 16,
  shadows: [
    Shadow(color: Colors.black87, offset: Offset(1, 1)),
  ],
);

const ktPerfogramaGreyWithShadow = TextStyle(
  color: Colors.white38,
  fontFamily: 'Perfograma',
  fontSize: 54,
  shadows: [
    Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 20),
    Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 20),
    Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 20)
  ],
);

const kgTextGradient = LinearGradient(
  colors: [Colors.red, Color.fromARGB(255, 172, 5, 5)],
  stops: [0.3, 0.7],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const ktAgencyFB = TextStyle(
  color: Colors.white,
  fontFamily: 'AgencyFB',
  fontStyle: FontStyle.italic,
);
const ktPerfogmaDisplay = TextStyle(
  fontFamily: kfPerfograma,
  color: Color(0xccFFFFFF),
  fontSize: 54,
  fontWeight: FontWeight.w100,
  shadows: [
    Shadow(
      color: Color.fromRGBO(183, 28, 28, 1),
      blurRadius: 20,
      offset: Offset(-1.4, -2),
    ),
    Shadow(
      color: Color.fromRGBO(229, 57, 53, 1),
      blurRadius: 8,
      offset: Offset(1.4, -1),
    ),
    Shadow(
      color: Color.fromRGBO(229, 115, 115, 1),
      blurRadius: 26,
      offset: Offset(-2, 1),
    ),
    Shadow(
      color: Color.fromRGBO(211, 47, 47, 1),
      blurRadius: 26,
      offset: Offset(2, 2.4),
    ),
    Shadow(
      color: Color.fromRGBO(229, 57, 53, 1),
      blurRadius: 60,
      offset: Offset(-1, 2),
    ),
  ],
);

const ktPerfogmaLess = TextStyle(
  fontFamily: kfPerfograma,
  color: Color(0xccFFFFFF),
  fontSize: 54,
  fontWeight: FontWeight.w100,
  shadows: [
    Shadow(
      color: Color.fromRGBO(183, 28, 28, 1),
      blurRadius: 16,
      offset: Offset(-1.4, -2),
    ),
    Shadow(
      color: Color.fromRGBO(229, 57, 53, 1),
      blurRadius: 8,
      offset: Offset(1.4, -1),
    ),
    Shadow(
      color: Color.fromRGBO(229, 115, 115, 1),
      blurRadius: 12,
      offset: Offset(-2, 1),
    ),
    Shadow(
      color: Color.fromRGBO(211, 47, 47, 1),
      blurRadius: 26,
      offset: Offset(2, 2.4),
    ),
    Shadow(
      color: Color.fromRGBO(229, 57, 53, 1),
      blurRadius: 10,
      offset: Offset(-1, 2),
    ),
  ],
);
