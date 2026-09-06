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
  String get raceHuman => 'Human';

  @override
  String get raceElf => 'Elf';

  @override
  String get raceDwarf => 'Dwarf';

  @override
  String get raceHalfling => 'Halfling';

  @override
  String get raceOrc => 'Orc';

  @override
  String get raceGnome => 'Gnome';

  @override
  String get raceCentaur => 'Centaur';

  @override
  String get raceLizardGuy => 'Lizard Guy';

  @override
  String get classWarrior => 'Warrior';

  @override
  String get classWizard => 'Wizard';

  @override
  String get classCleric => 'Cleric';

  @override
  String get classThief => 'Thief';

  @override
  String get classBard => 'Bard';

  @override
  String get classRanger => 'Ranger';

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
  String get battleAlreadyPlayed =>
      'You already fought a monster this turn. Only some cards let you fight twice — start another battle anyway?';

  @override
  String get escapeOutcome => 'Did you survive?';

  @override
  String get survivedEscape => 'Survived';

  @override
  String get diedInBattle => 'Died (Bad Stuff)';

  @override
  String diedInBattleConfirm(int level) {
    return 'The monster\'s Bad Stuff struck home: you shrink back to level $level. Confirm?';
  }

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
  String removePlayerConfirm(String name) {
    return 'Remove $name from the room? They\'ll need to rejoin with the invite to come back.';
  }

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
  String get viewStatistics => 'Game history';

  @override
  String get rules => 'How to play';

  @override
  String get rulesTurnTitle => 'Your turn';

  @override
  String get rulesTurnBody =>
      'Open a door, deal with what\'s behind it (fight, loot, or run), then optionally loot the room. Finish with \"End turn\" so the next player goes.';

  @override
  String get rulesCombatTitle => 'Combat';

  @override
  String get rulesCombatBody =>
      'Compare total power. If you\'re stronger, press \"I can win\" - a countdown starts before it\'s locked in. If you\'re weaker, ask for help, run away, or accept the monster\'s Bad Stuff.';

  @override
  String get rulesInterventionTitle => 'Intervening';

  @override
  String get rulesInterventionBody =>
      'Any other player can intervene during the victory countdown by playing a card that changes the fight (a monster enhancer, a curse, help). Only the first intervention counts - the server rejects late ones.';

  @override
  String get rulesEscapeTitle => 'Running away';

  @override
  String get rulesEscapeBody =>
      'Roll to escape - a 5 or 6 usually succeeds, unless a card says otherwise. If you make it, the battle ends with no reward and no penalty. If you don\'t, the monster\'s Bad Stuff applies - usually you shrink back down to the table\'s minimum level.';

  @override
  String get rulesIdentityTitle => 'Race & class';

  @override
  String get rulesIdentityBody =>
      'Humans have no race card and no special ability. Elves, Dwarves, Halflings and the expansion races each grant abilities from their card. Super Munchkin lets you hold two classes at once, and Half-Breed lets you hold two races - the app supports selecting more than one.';

  @override
  String get rulesWinningTitle => 'Winning';

  @override
  String get rulesWinningBody =>
      'The first munchkin to reach the table\'s maximum level (10 in the standard game) and defeat one more monster wins the game.';

  @override
  String get localPlayers => 'Players on this device';

  @override
  String get localPlayersHint =>
      'Add players who will take turns using this device. They do not need their own phones.';

  @override
  String get addLocalPlayer => 'Add player';

  @override
  String get duplicatePlayerName => 'Player names must be unique.';

  @override
  String get localPlayerTag => 'This device';

  @override
  String get addLocalPlayerTitle => 'Add a player on this device';

  @override
  String get playerNameLabel => 'Player name';

  @override
  String get gameWinnerBadge => 'Winner';

  @override
  String gameWinnerAnnouncement(String name, int level) {
    return '$name reached level $level and won the game!';
  }

  @override
  String get endGameNow => 'End the game';

  @override
  String peakLevelCaption(int level) {
    return 'Peak this game: $level';
  }

  @override
  String get openDoor => 'Open a door';

  @override
  String get openDoorHint =>
      'Deal with whatever is behind it, then start a battle or end your turn.';

  @override
  String get escapeRollHint =>
      'A roll of 5 or 6 usually succeeds, unless a card says otherwise.';

  @override
  String get upNextTag => 'Up next';

  @override
  String get decreaseLevel => 'Decrease level';

  @override
  String get increaseLevel => 'Increase level';

  @override
  String get shareInvite => 'Share invite';
}
