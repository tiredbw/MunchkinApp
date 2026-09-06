// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tabletop Companion';

  @override
  String get homeTagline => 'Local Wi-Fi companion for tabletop game nights';

  @override
  String get createRoom => 'Create room';

  @override
  String get joinRoom => 'Join room';

  @override
  String get restoreGame => 'Restore saved game';

  @override
  String get yourName => 'Your name';

  @override
  String get hostAddress => 'Host address';

  @override
  String get port => 'Port';

  @override
  String get pin => '6-digit PIN';

  @override
  String get scanQr => 'Scan QR code';

  @override
  String get players => 'Players';

  @override
  String get myCharacter => 'My character';

  @override
  String get currentTurn => 'Current turn';

  @override
  String get level => 'Level';

  @override
  String get strength => 'Strength';

  @override
  String get totalPower => 'Total power';

  @override
  String get identity => 'Race & class';

  @override
  String get trackRaceClass => 'Track race & class';

  @override
  String get raceNone => 'No race';

  @override
  String get raceHuman => 'Human';

  @override
  String get raceElf => 'Elf';

  @override
  String get raceDwarf => 'Dwarf';

  @override
  String get raceHalfling => 'Halfling';

  @override
  String get classNone => 'No class';

  @override
  String get classWarrior => 'Warrior';

  @override
  String get classWizard => 'Wizard';

  @override
  String get classCleric => 'Cleric';

  @override
  String get classThief => 'Thief';

  @override
  String get closeLobby => 'Close lobby';

  @override
  String get startGame => 'Start game';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get endTurn => 'End turn';

  @override
  String get startBattle => 'Start battle';

  @override
  String get canWin => 'I can win';

  @override
  String get cannotWin => 'I cannot win';

  @override
  String get intervene => 'Intervene';

  @override
  String get requestHelp => 'Request help';

  @override
  String get escape => 'Run away';

  @override
  String get backToBattle => 'Back to battle';

  @override
  String get finishBattle => 'Finish battle';

  @override
  String get raiseLevel => 'Raise level';

  @override
  String get rollDice => 'Roll D6';

  @override
  String get physicalDice => 'Roll the physical die';

  @override
  String get endGame => 'End game';

  @override
  String get endGameConfirm =>
      'End the game for everyone? This cannot be undone.';

  @override
  String get connected => 'Connected';

  @override
  String get offline => 'Offline';

  @override
  String activePlayer(String name) {
    return 'Current player: $name';
  }

  @override
  String get roomInvite => 'Room invite';

  @override
  String get waitingForPlayers => 'Waiting for players';

  @override
  String get waitingForHost => 'Waiting for the host';

  @override
  String victoryCountdown(int seconds) {
    return 'Victory in $seconds s';
  }

  @override
  String diceResult(String name, int value) {
    return '$name rolled $value';
  }

  @override
  String get settings => 'Room settings';

  @override
  String get virtualDice => 'Virtual die';

  @override
  String get realDice => 'Physical die';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get retry => 'Retry';

  @override
  String get leave => 'Leave room';

  @override
  String get youTag => 'You';

  @override
  String get error => 'Something went wrong';

  @override
  String get manualJoin => 'Join manually';

  @override
  String get roomId => 'Room ID';

  @override
  String get minimum => 'Minimum';

  @override
  String get maximum => 'Maximum';

  @override
  String get initial => 'Initial';

  @override
  String get countdownSeconds => 'Countdown (seconds)';

  @override
  String get confirmOrder => 'Confirm order';

  @override
  String get reopenLobby => 'Reopen lobby';

  @override
  String get copyInvite => 'Copy invite';

  @override
  String get inviteCopied => 'Invite copied';

  @override
  String get interventionReceived => 'An intervention was made';

  @override
  String get helpRequested => 'The active player needs help';

  @override
  String get battleWon => 'Battle won';

  @override
  String get escapingNow => 'Resolve the escape at the table';

  @override
  String get finishEscape => 'Finish escape';

  @override
  String get noSavedGame => 'No saved game found';

  @override
  String get invalidForm => 'Check the entered values';

  @override
  String get gameEnded => 'The game has ended';

  @override
  String get removePlayer => 'Remove player';

  @override
  String get roomClosed => 'Joining is closed';

  @override
  String get resumeBattle => 'Resume battle';

  @override
  String get hostMustStayOpen => 'The host app must remain open';

  @override
  String get connectionError => 'Could not connect to the host';

  @override
  String get adPrivacyOptions => 'Ad privacy options';
}
