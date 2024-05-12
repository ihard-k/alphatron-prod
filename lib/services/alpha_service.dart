import 'dart:math';

import 'package:alphatron/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game_framework/game_framework.dart';
import 'package:random_name_generator/random_name_generator.dart';

final highScoreNotifier = ValueNotifier<int>(0);

class AlphaService with ChangeNotifier, EventListener {
  //
  late String deviceId;
  late String socketKey;
  late String displayName;
  int roundLength = 60;
  final int _maxPlayTime = 3600;
  final int _numberOfRounds = 0;
  int highScore = 0;
  // final int _maxPlayers = 1;

  GameClient? gameClient;
  DeviceSessionConfig? sessionConfig;
  String userName = "";
  Map<String, dynamic> jsonConfig = {};

  GameType _selectedGameType = GameType.solo;
  final int _maxPlayers = 5;
  PlayerRanking minRank = PlayerRanking.novice, maxRank = PlayerRanking.skilled;

  // String? _selectedMatchId;

  AlphaService._();

  static AlphaService? _instance;

  static AlphaService get instance {
    return _instance ??= AlphaService._();
  }

  Set<String> correctWordsSet = {
    "act",
    "cat",
    "take",
    "make",
    "mate",
  };

  String seedWord = "MACTKE";
  PlayerService? playerService;

  GameController? gameController;

  GameModel? gameModel;

  MatchMaker? matchMaker;

  String gameStatus = 'Not initialised';

  List<String> localPlayerWordIgnoreList = [];

  LocalPlayer? localPlayer;

  List<MatchResult> matches = [];

  // final List<UserRoom> _availableRooms = [];

  Future<void> initAlphatron({GameType? gameType}) async {
    _selectedGameType = gameType ?? GameType.solo;
    final list = List.generate(
        10, (index) => generateRandomString(Random().nextInt(6) + 2));
    list.sort((a, b) => a.length.compareTo(b.length));

    correctWordsSet = list.toSet();

    await fromServer();
    notifyListeners();
  }

  @override
  void handleError(error) {
    print(error.toString());
  }

  @override
  Future<void> handleEvent(AppEvent event) async {
    print("event:${event.runtimeType}");

    if (event is AvailableRoomsEvent) {
      onAvailableRooms(event.rooms);
    } else if (event is PlayerLeftGameEvent) {
      onPlayerRemoved(event.player);
    } else if (event is RoundWordListConfigEvent) {
      onRoundWordListConfig(
        event.nextRound,
        event.puzzleType,
        event.seedWord,
        event.shuffledWord,
        event.puzzleWords.map((e) => e.word).toList(),
        event.overflowWords.map((e) => e.word).toList(),
      );
    } else if (event is ReadyToStartEvent) {
      onGameReadyToStart(event.matchSpec);
    } else if (event is RoundCountdownStartEvent) {
      onRoundCountdownStart(event.nextRound, event.targetTime);
    } else if (event is RoundStartEvent) {
      onRoundStart(event.currentRound, event.targetTime);
    } else if (event is PlayerJoinedGameEvent) {
      onPlayerAdded(event.player);
    } else if (event is WordGuessEvent) {
      onWordGuessed(event.player, event.guess);
    } else if (event is WordGuessCorrectEvent) {
      onWordGuessedCorrectly(
          event.player, event.guess, event.points, event.isOverflowWord);
    } else if (event is WordGuessIncorrectEvent) {
      onWordGuessedIncorrectly(event.player, event.guess);
    } else if (event is WordAlreadyGuessedEvent) {
      onWordAlreadyGuessed(event.player, event.guess, event.isOverflowWord);
    } else if (event is RoundCompleteEvent) {
      onRoundComplete(event.completedEarly);
    } else if (event is GameCompleteEvent) {
      onGameComplete(event.reason);
    }
  }

  void onRoundStart(int currentRound, DateTime targetTime) {
    roundLength = targetTime.difference(DateTime.now()).inSeconds;
    notifyListeners();
  }

  void onRoundCountdownStart(int nextRound, DateTime targetTime) {}
  void onPlayerRemoved(Player player) {}
  void onAvailableRooms(List<UserRoom> rooms) {}
  void onRoundComplete(bool completedEarly) {}
  void onGameComplete(GameCompletionStatus reason) {}
  void onWordAlreadyGuessed(Player player, String guess, bool isOverflowWord) {}
  void onWordGuessedIncorrectly(Player player, String guess) {}
  void onWordGuessedCorrectly(
      Player player, String guess, int points, bool isOverflowWord) {
    if (player.isLocalPlayer()) {
      highScoreNotifier.value = player.totalGameScore;
    }
  }

  void onWordGuessed(Player player, String guess) {
    if (player.isLocalPlayer()) {
      highScore = player.totalGameScore;
      print(highScore);
      notifyListeners();
    }
  }

  void onGameReadyToStart(MatchSpecification matchSpec) {
    gameController!.startGame(matchSpec);
  }

  void onPlayerAdded(Player player) {}

  void onRoundWordListConfig(
    int nextRound,
    WordListStyle puzzleType,
    String seedWord,
    String shuffledWord,
    List<String> words,
    List<String> overflowWords,
  ) {
    correctWordsSet = words.toSet();
    this.seedWord = seedWord.shuffleString();
  }

  Future<void> fromServer() async {
    deviceId = generateRandomString(30);

    socketKey = generateRandomString(30);
    var randomNames = RandomNames(Zone.india);
    displayName = randomNames.manName();
    sessionConfig =
        DeviceSessionConfig(deviceId: deviceId, displayName: displayName);

    initializeGameClient();

    jsonConfig = await gameClient!
        .registerUserDevice(displayName, GameDifficultyType.medium);
    await createGameInstance(joinMatch: true);
  }

  void initializeGameClient() {
    gameClient = GameClient(
      httpHost: dotenv.env['NAKAMA_HTTP_HOST'] ?? '',
      httpSsl: dotenv.env['NAKAMA_HTTP_SSL']?.toLowerCase() != 'false',
      serverKey: dotenv.env['NAKAMA_SERVER_KEY'] ?? '',
      grpcPort: int.parse(dotenv.env['NAKAMA_GRPC_PORT'] ?? "7349"),
      httpPort: int.parse(dotenv.env['NAKAMA_HTTP_PORT'] ?? "7350"),
      socketHost: dotenv.env['NAKAMA_SOCKET_HOST'] ?? '',
      socketSsl: dotenv.env['NAKAMA_SOCKET_SSL']?.toLowerCase() != 'false',
      socketKey: socketKey,
      sessionConfig: sessionConfig!,
    );
  }

  Future<void> _connectToNakama() async {
    if (sessionConfig?.session == null) {
      await gameClient!.connect();
    }
    if (userName.isEmpty) {
      userName = sessionConfig!.userName!;

      localPlayer = LocalPlayer(
        playerType: PlayerType.localHuman,
        userId: sessionConfig!.userId!,
        userName: userName,
        displayName: displayName,
        rank: PlayerRanking.skilled,
        rankPercent: 10,
        eloRating: PlayerRanking.skilled.getMinimumEloRatingForRanking(),
        maxWordObscurity: jsonConfig['metadata']['maxWordObscurity'],
        maxWordLength: jsonConfig['metadata']['maxWordLength'],
        highScore: jsonConfig['metadata']['highScore'],
        maxRound: jsonConfig['metadata']['maxRound'],
        totalAccumulatedPoints: jsonConfig['metadata']['totalPoints'],
        totalCoins: jsonConfig['wallet']['coins'],
        wordIgnoreList: localPlayerWordIgnoreList,
      );
    }
  }

  Future<void> createGameInstance(
      {bool joinMatch = false, bool createOnly = false}) async {
    await _connectToNakama();
    // if (matchMaker != null || gameController != null) {
    //   return Future.value();
    // }

    print("are we here $_selectedGameType");

    if (_selectedGameType == GameType.solo) {
      matchMaker = MatchMaker(gameClient!);
      gameModel = SoloGameModel(
        gameConfig: jsonConfig,
        client: gameClient!,
        firstRoundCountdownSeconds: 3,
        subsequentRoundCountdownSeconds: 3,
        maxLettersX: 10, // Maximum number
        maxLettersY: 8, //
      ); // Maximum number of letters we can fit vertically - needs to be calculated

      gameController = SoloGameController(gameModel!);
      var lobby = Lobby(10);
      playerService =
          PlayerService(gameModel!, gameController!, matchMaker!, lobby);
      addKeyedSubscription(
          subscriptionKey: 'viewGameModel', events: gameModel!.events);

      await matchMaker!.createMatch(
        localPlayer!,
        MatchSpecification(
          numRounds: _numberOfRounds,
          roundLength: roundLength,
          minWordLength: 6,
          maxPlayTime: _maxPlayTime,
        ),
      );
    } else if (_selectedGameType == GameType.ai) {
      matchMaker = MatchMaker(gameClient!);
      gameModel = AiGameModel(
        gameConfig: jsonConfig,
        client: gameClient!,
        firstRoundCountdownSeconds: 3,
        subsequentRoundCountdownSeconds: 3,
        maxLettersX: 10,
        // Maximum number of letters we can fit horizontally - needs to be calculated
        maxLettersY: 8,
      ); // Maximum number of letters we can fit vertically - needs to be calculated);

      gameController = GameController(gameModel!);
      var lobby = Lobby(10);
      playerService = AiPlayerService(gameModel!, gameController!, matchMaker!,
          lobby, jsonConfig['aiPlayers']);
      addKeyedSubscription(
          subscriptionKey: 'viewGameModel', events: gameModel!.events);

      await matchMaker!.createMatch(
        localPlayer!,
        AiMatchSpecification(
          minPlayers: _maxPlayers,
          maxPlayers: _maxPlayers,
          roundLength: roundLength,
          numRounds: _numberOfRounds,
          minWordLength: 3,
          maxWordLength: 10,
          minRank: minRank,
          maxRank: maxRank,
          maxPlayTime: _maxPlayTime,
        ),
      );
    }
  }
}

typedef VoidStreamEvent = void Function(
    {required Stream<AppEvent> events, String subscriptionKey});

enum GameType { solo, ai, online, withFriends }
