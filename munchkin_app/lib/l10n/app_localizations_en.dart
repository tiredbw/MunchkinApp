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
  String get waitingForActivePlayer => 'Waiting for the active player';

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
  String get levelRewardClaimed => 'Victory level received';

  @override
  String get recordPhysicalRoll => 'Record physical roll';

  @override
  String get useCheatDie => 'Use Cheat Die';

  @override
  String get appealCheatDie => 'Appeal Cheat Die';

  @override
  String get diceAppealPending =>
      'Waiting for the host to resolve the dice appeal';

  @override
  String get restoreOriginalRoll => 'Restore original';

  @override
  String get keepCheatRoll => 'Keep result';

  @override
  String get originalRoll => 'Original roll';

  @override
  String get cheatDieApplied => 'Cheat Die applied';

  @override
  String get increaseLevel => 'Increase level';

  @override
  String get decreaseLevel => 'Decrease level';

  @override
  String get showInvite => 'Show room invite';

  @override
  String get continueGame => 'Continue game';

  @override
  String get continueGameFailed =>
      'The host is unavailable. Try again or scan a new QR code.';

  @override
  String get statsLockedDuringBattle =>
      'Level and strength cannot be changed during a battle.';

  @override
  String get controlProfile => 'Switch player';

  @override
  String playingAs(String name) {
    return 'Playing as $name';
  }

  @override
  String controlRequested(String name) {
    return 'The host wants this device to control $name.';
  }

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get assignDevice => 'Assign to a device';

  @override
  String get revokeAssignment => 'Revoke assignment';

  @override
  String get pendingAssignment => 'Waiting for confirmation';

  @override
  String controlledOnDevice(String name) {
    return 'On $name\'s device';
  }

  @override
  String get chooseDevice => 'Choose a device';

  @override
  String get statistics => 'Statistics';

  @override
  String get gameHistory => 'Game history';

  @override
  String get gamesPlayed => 'Games played';

  @override
  String get wins => 'Wins';

  @override
  String get maxLevelReached => 'Maximum level';

  @override
  String get averageDuration => 'Average duration';

  @override
  String get personalProfiles => 'Personal profiles';

  @override
  String get addProfile => 'Add profile';

  @override
  String get profileName => 'Profile name';

  @override
  String get noProfiles => 'No profiles yet. Add one or start a game.';

  @override
  String get noGameHistory => 'No completed games for this profile.';

  @override
  String get noWinner => 'No winner';

  @override
  String winnerNames(String names) {
    return 'Winner: $names';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get battleAlreadyPlayed =>
      'A battle has already been played this turn. End the turn to start another one.';

  @override
  String get localPlayers => 'Players on this device';

  @override
  String get localPlayersHint =>
      'Add players who will take turns using the host device. They do not need phones.';

  @override
  String get addLocalPlayer => 'Add player';

  @override
  String get duplicatePlayerName => 'Player names must be unique.';
}
