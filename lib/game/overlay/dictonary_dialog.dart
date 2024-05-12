import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:alphatron/constants/game_const.dart';
import 'package:alphatron/game/game.dart';

import '../../constants/images.dart';
import '../../utils/size_config.dart';

class DictionaryDialog extends StatefulWidget {
  final WordGame game;

  const DictionaryDialog(this.game, {super.key});

  @override
  State<DictionaryDialog> createState() => _DictionaryDialogState();
}

class _DictionaryDialogState extends State<DictionaryDialog> {
  List fine = [
    const DictionaryWord(id: '1.', desc: '(adjective) Of superior quality.'),
    const DictionaryWord(
        id: '2.',
        desc:
            '(adjective) Of a particular grade of quality, usually between very good and very fine, and below mint.'),
    const DictionaryWord(id: '3.', desc: '(adjective) Sunny and not raining.'),
    const DictionaryWord(
        id: '4.',
        desc:
            '(adjective) Being accepptable, adequate, passable, of satisfactory.'),
    const DictionaryWord(
        id: '5.', desc: '(adjective) Good-looking, attractive.'),
    const DictionaryWord(
        id: '6.',
        desc:
            '(adjective) Consisting of especially minute particulate; made up of particularly small pieces.'),
    const DictionaryWord(
        id: '7.',
        desc:
            '(adjective) Particularly slende; especially thin, narrow, or of small girth.'),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: SizeConfig.screenHeight,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 1),
        child: Container(
          height: SizeConfig.screenHeight * 0.67,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 3,
              vertical: SizeConfig.safeBlockHorizontal * 5),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(fsilverbg),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Gap(10),
                  Image.asset(
                    ftitle,
                    width: SizeConfig.screenWidth * 0.25,
                  ),
                  const Gap(5),
                  Image.asset(
                    fflash,
                    width: SizeConfig.screenWidth * 0.7,
                  ),
                  const Gap(8),
                  Container(
                    height: SizeConfig.screenHeight * 0.55,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(fredbg),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...(fine)
                            .map(
                              (data) => FineRuleWidget(data: data),
                            )
                            .toList()
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    widget.game.overlays.remove(ksDictionaryOverlay);
                  },
                  child: Image.asset(
                    fexit,
                    width: SizeConfig.screenWidth * 0.05,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FineRuleWidget extends StatelessWidget {
  final DictionaryWord data;
  const FineRuleWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.id,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'AgencyFB',
            // fontStyle: FontStyle.italic,
            fontSize: SizeConfig.safeBlockHorizontal * 5.5,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Gap(5),
        Expanded(
            child: Text(
          data.desc,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'AgencyFB',
            fontSize: SizeConfig.safeBlockHorizontal * 5.5,
          ),
        ))
      ],
    );
  }
}

class DictionaryWord {
  final String id;
  final String desc;
  const DictionaryWord({
    required this.id,
    required this.desc,
  });
}
