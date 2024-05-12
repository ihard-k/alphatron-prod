import '../constants/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/theme.dart';
import '../utils/size_config.dart';
import 'widgets/select_game_list_widget.dart';

class SelectGameDialogBox extends StatefulWidget {
  const SelectGameDialogBox({super.key});

  @override
  State<SelectGameDialogBox> createState() => _SelectGameDialogBoxState();
}

class _SelectGameDialogBoxState extends State<SelectGameDialogBox> {
  final List selectGameList = [
    {
      'id': '1',
      'name': 'SOLO',
      'status': 'active',
    },
    {
      'id': '2',
      'name': 'AI',
      'status': 'active',
    },
    {
      'id': '3',
      'name': 'ONLINE[RANDOM PLAYERS]',
      'status': 'active',
    },
    {
      'id': '4',
      'name': 'ONLINE[MY ROOM]',
      'status': 'active',
    },
    {
      'id': '5',
      'name': 'ONLINE[FRIEND_1]',
      'status': 'active',
    },
    {
      'id': '6',
      'name': 'ONLINE[FRIEND_2]',
      'status': 'inactive',
    },
    {
      'id': '7',
      'name': 'ONLINE[FRIEND_3]',
      'status': 'disabled',
    },
    {
      'id': '8',
      'name': 'ONLINE[FRIEND_4]',
      'status': 'disabled',
    },
    {
      'id': '9',
      'name': 'ONLINE[FRIEND_5]',
      'status': 'inactive',
    },
    {
      'id': '7',
      'name': 'ONLINE[FRIEND_3]',
      'status': 'disabled',
    },
    {
      'id': '8',
      'name': 'ONLINE[FRIEND_4]',
      'status': 'disabled',
    },
    {
      'id': '9',
      'name': 'ONLINE[FRIEND_5]',
      'status': 'inactive',
    },
  ];

  double scrollOffset = 0.0;
  // final _controller = ScrollController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        // scrollOffset = _controller.offset;
        scrollOffset =
            _controller.position.pixels / _controller.position.maxScrollExtent;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        height: SizeConfig.screenHeight,
        alignment: Alignment.center,
        color: Colors.black38,
        child: Stack(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.85,
              width: SizeConfig.screenWidth,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 3,
                  vertical: SizeConfig.safeBlockHorizontal * 5),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(mainBG),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal * 4),
                child: Column(
                  children: [
                    const Gap(1),
                    Container(
                      height: SizeConfig.screenHeight * 0.21,
                      width: SizeConfig.screenWidth * 0.41,
                      padding: const EdgeInsets.all(28),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(blackCircleRing),
                        ),
                      ),
                      child: Image.asset(
                        modelList,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      "SELECT GAME",
                      style: ktPorticoWhite.copyWith(
                        fontSize: 25,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: SizeConfig.screenHeight * 0.4,
                                width: SizeConfig.screenWidth * 0.035,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(vtScrollBg),
                                  ),
                                ),
                              ),
                              Positioned(
                                // top: scrollOffset * 0.93,
                                top: scrollOffset *
                                    (MediaQuery.of(context).size.height * 0.34),

                                child: GestureDetector(
                                  onVerticalDragUpdate: (details) {
                                    setState(() {
                                      double newPosition = (scrollOffset *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) +
                                          details.delta.dy;
                                      scrollOffset = newPosition.clamp(
                                              0.0,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          MediaQuery.of(context).size.height;
                                    });

                                    double newScrollPosition = scrollOffset *
                                        _controller.position.maxScrollExtent;
                                    _controller.jumpTo(newScrollPosition);
                                  },
                                  // onVerticalDragUpdate: (details) {
                                  //   setState(() {
                                  //     _controller.position
                                  //         .jumpTo(details.localPosition.dy);
                                  //   });
                                  // },
                                  child: Image.asset(
                                    width: SizeConfig.screenWidth * 0.035,
                                    vtScrollBtnBg,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _controller,
                              child: Column(
                                children: selectGameList
                                    .map(
                                      (sGame) => SelectGameListWidget(
                                        title: sGame['name'],
                                        status: sGame['status'],
                                        selected: sGame['id'] == '4',
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 15,
                        vertical: SizeConfig.safeBlockVertical * 2,
                      ),
                      // height: SizeConfig.screenHeight * 0.07,
                      //   width: SizeConfig.screenWidth * 0.5,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(redHrBtnBg),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Text(
                        "SELECT",
                        style: ktPorticoWhite.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
    );
  }
}
