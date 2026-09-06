import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tabletop Companion'**
  String get appTitle;

  /// No description provided for @homeTagline.
  ///
  /// In en, this message translates to:
  /// **'Local Wi-Fi companion for tabletop game nights'**
  String get homeTagline;

  /// No description provided for @createRoom.
  ///
  /// In en, this message translates to:
  /// **'Create room'**
  String get createRoom;

  /// No description provided for @joinRoom.
  ///
  /// In en, this message translates to:
  /// **'Join room'**
  String get joinRoom;

  /// No description provided for @restoreGame.
  ///
  /// In en, this message translates to:
  /// **'Restore saved game'**
  String get restoreGame;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @hostAddress.
  ///
  /// In en, this message translates to:
  /// **'Host address'**
  String get hostAddress;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @pin.
  ///
  /// In en, this message translates to:
  /// **'6-digit PIN'**
  String get pin;

  /// No description provided for @scanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQr;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @myCharacter.
  ///
  /// In en, this message translates to:
  /// **'My character'**
  String get myCharacter;

  /// No description provided for @currentTurn.
  ///
  /// In en, this message translates to:
  /// **'Current turn'**
  String get currentTurn;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @strength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get strength;

  /// No description provided for @totalPower.
  ///
  /// In en, this message translates to:
  /// **'Total power'**
  String get totalPower;

  /// No description provided for @identity.
  ///
  /// In en, this message translates to:
  /// **'Race & class'**
  String get identity;

  /// No description provided for @trackRaceClass.
  ///
  /// In en, this message translates to:
  /// **'Track race & class'**
  String get trackRaceClass;

  /// No description provided for @raceHuman.
  ///
  /// In en, this message translates to:
  /// **'Human'**
  String get raceHuman;

  /// No description provided for @raceElf.
  ///
  /// In en, this message translates to:
  /// **'Elf'**
  String get raceElf;

  /// No description provided for @raceDwarf.
  ///
  /// In en, this message translates to:
  /// **'Dwarf'**
  String get raceDwarf;

  /// No description provided for @raceHalfling.
  ///
  /// In en, this message translates to:
  /// **'Halfling'**
  String get raceHalfling;

  /// No description provided for @raceOrc.
  ///
  /// In en, this message translates to:
  /// **'Orc'**
  String get raceOrc;

  /// No description provided for @raceGnome.
  ///
  /// In en, this message translates to:
  /// **'Gnome'**
  String get raceGnome;

  /// No description provided for @raceCentaur.
  ///
  /// In en, this message translates to:
  /// **'Centaur'**
  String get raceCentaur;

  /// No description provided for @raceLizardGuy.
  ///
  /// In en, this message translates to:
  /// **'Lizard Guy'**
  String get raceLizardGuy;

  /// No description provided for @classWarrior.
  ///
  /// In en, this message translates to:
  /// **'Warrior'**
  String get classWarrior;

  /// No description provided for @classWizard.
  ///
  /// In en, this message translates to:
  /// **'Wizard'**
  String get classWizard;

  /// No description provided for @classCleric.
  ///
  /// In en, this message translates to:
  /// **'Cleric'**
  String get classCleric;

  /// No description provided for @classThief.
  ///
  /// In en, this message translates to:
  /// **'Thief'**
  String get classThief;

  /// No description provided for @classBard.
  ///
  /// In en, this message translates to:
  /// **'Bard'**
  String get classBard;

  /// No description provided for @classRanger.
  ///
  /// In en, this message translates to:
  /// **'Ranger'**
  String get classRanger;

  /// No description provided for @closeLobby.
  ///
  /// In en, this message translates to:
  /// **'Close lobby'**
  String get closeLobby;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get startGame;

  /// No description provided for @shuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// No description provided for @endTurn.
  ///
  /// In en, this message translates to:
  /// **'End turn'**
  String get endTurn;

  /// No description provided for @startBattle.
  ///
  /// In en, this message translates to:
  /// **'Start battle'**
  String get startBattle;

  /// No description provided for @canWin.
  ///
  /// In en, this message translates to:
  /// **'I can win'**
  String get canWin;

  /// No description provided for @cannotWin.
  ///
  /// In en, this message translates to:
  /// **'I cannot win'**
  String get cannotWin;

  /// No description provided for @intervene.
  ///
  /// In en, this message translates to:
  /// **'Intervene'**
  String get intervene;

  /// No description provided for @requestHelp.
  ///
  /// In en, this message translates to:
  /// **'Request help'**
  String get requestHelp;

  /// No description provided for @escape.
  ///
  /// In en, this message translates to:
  /// **'Run away'**
  String get escape;

  /// No description provided for @backToBattle.
  ///
  /// In en, this message translates to:
  /// **'Back to battle'**
  String get backToBattle;

  /// No description provided for @finishBattle.
  ///
  /// In en, this message translates to:
  /// **'Finish battle'**
  String get finishBattle;

  /// No description provided for @battleAlreadyPlayed.
  ///
  /// In en, this message translates to:
  /// **'You already fought a monster this turn. Only some cards let you fight twice — start another battle anyway?'**
  String get battleAlreadyPlayed;

  /// No description provided for @escapeOutcome.
  ///
  /// In en, this message translates to:
  /// **'Did you survive?'**
  String get escapeOutcome;

  /// No description provided for @survivedEscape.
  ///
  /// In en, this message translates to:
  /// **'Survived'**
  String get survivedEscape;

  /// No description provided for @diedInBattle.
  ///
  /// In en, this message translates to:
  /// **'Died (Bad Stuff)'**
  String get diedInBattle;

  /// No description provided for @diedInBattleConfirm.
  ///
  /// In en, this message translates to:
  /// **'The monster\'s Bad Stuff struck home: you shrink back to level {level}. Confirm?'**
  String diedInBattleConfirm(int level);

  /// No description provided for @raiseLevel.
  ///
  /// In en, this message translates to:
  /// **'Raise level'**
  String get raiseLevel;

  /// No description provided for @rollDice.
  ///
  /// In en, this message translates to:
  /// **'Roll D6'**
  String get rollDice;

  /// No description provided for @physicalDice.
  ///
  /// In en, this message translates to:
  /// **'Roll the physical die'**
  String get physicalDice;

  /// No description provided for @endGame.
  ///
  /// In en, this message translates to:
  /// **'End game'**
  String get endGame;

  /// No description provided for @endGameConfirm.
  ///
  /// In en, this message translates to:
  /// **'End the game for everyone? This cannot be undone.'**
  String get endGameConfirm;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @activePlayer.
  ///
  /// In en, this message translates to:
  /// **'Current player: {name}'**
  String activePlayer(String name);

  /// No description provided for @roomInvite.
  ///
  /// In en, this message translates to:
  /// **'Room invite'**
  String get roomInvite;

  /// No description provided for @waitingForPlayers.
  ///
  /// In en, this message translates to:
  /// **'Waiting for players'**
  String get waitingForPlayers;

  /// No description provided for @waitingForHost.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the host'**
  String get waitingForHost;

  /// No description provided for @victoryCountdown.
  ///
  /// In en, this message translates to:
  /// **'Victory in {seconds} s'**
  String victoryCountdown(int seconds);

  /// No description provided for @diceResult.
  ///
  /// In en, this message translates to:
  /// **'{name} rolled {value}'**
  String diceResult(String name, int value);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Room settings'**
  String get settings;

  /// No description provided for @virtualDice.
  ///
  /// In en, this message translates to:
  /// **'Virtual die'**
  String get virtualDice;

  /// No description provided for @realDice.
  ///
  /// In en, this message translates to:
  /// **'Physical die'**
  String get realDice;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave room'**
  String get leave;

  /// No description provided for @youTag.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get youTag;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error;

  /// No description provided for @manualJoin.
  ///
  /// In en, this message translates to:
  /// **'Join manually'**
  String get manualJoin;

  /// No description provided for @roomId.
  ///
  /// In en, this message translates to:
  /// **'Room ID'**
  String get roomId;

  /// No description provided for @minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get minimum;

  /// No description provided for @maximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get maximum;

  /// No description provided for @initial.
  ///
  /// In en, this message translates to:
  /// **'Initial'**
  String get initial;

  /// No description provided for @countdownSeconds.
  ///
  /// In en, this message translates to:
  /// **'Countdown (seconds)'**
  String get countdownSeconds;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get confirmOrder;

  /// No description provided for @reopenLobby.
  ///
  /// In en, this message translates to:
  /// **'Reopen lobby'**
  String get reopenLobby;

  /// No description provided for @copyInvite.
  ///
  /// In en, this message translates to:
  /// **'Copy invite'**
  String get copyInvite;

  /// No description provided for @inviteCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite copied'**
  String get inviteCopied;

  /// No description provided for @interventionReceived.
  ///
  /// In en, this message translates to:
  /// **'An intervention was made'**
  String get interventionReceived;

  /// No description provided for @helpRequested.
  ///
  /// In en, this message translates to:
  /// **'The active player needs help'**
  String get helpRequested;

  /// No description provided for @battleWon.
  ///
  /// In en, this message translates to:
  /// **'Battle won'**
  String get battleWon;

  /// No description provided for @escapingNow.
  ///
  /// In en, this message translates to:
  /// **'Resolve the escape at the table'**
  String get escapingNow;

  /// No description provided for @finishEscape.
  ///
  /// In en, this message translates to:
  /// **'Finish escape'**
  String get finishEscape;

  /// No description provided for @noSavedGame.
  ///
  /// In en, this message translates to:
  /// **'No saved game found'**
  String get noSavedGame;

  /// No description provided for @invalidForm.
  ///
  /// In en, this message translates to:
  /// **'Check the entered values'**
  String get invalidForm;

  /// No description provided for @gameEnded.
  ///
  /// In en, this message translates to:
  /// **'The game has ended'**
  String get gameEnded;

  /// No description provided for @removePlayer.
  ///
  /// In en, this message translates to:
  /// **'Remove player'**
  String get removePlayer;

  /// No description provided for @removePlayerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the room? They\'ll need to rejoin with the invite to come back.'**
  String removePlayerConfirm(String name);

  /// No description provided for @roomClosed.
  ///
  /// In en, this message translates to:
  /// **'Joining is closed'**
  String get roomClosed;

  /// No description provided for @resumeBattle.
  ///
  /// In en, this message translates to:
  /// **'Resume battle'**
  String get resumeBattle;

  /// No description provided for @hostMustStayOpen.
  ///
  /// In en, this message translates to:
  /// **'The host app must remain open'**
  String get hostMustStayOpen;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Could not connect to the host'**
  String get connectionError;

  /// No description provided for @adPrivacyOptions.
  ///
  /// In en, this message translates to:
  /// **'Ad privacy options'**
  String get adPrivacyOptions;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @gameHistory.
  ///
  /// In en, this message translates to:
  /// **'Game history'**
  String get gameHistory;

  /// No description provided for @gamesPlayed.
  ///
  /// In en, this message translates to:
  /// **'Games played'**
  String get gamesPlayed;

  /// No description provided for @wins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// No description provided for @maxLevelReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum level'**
  String get maxLevelReached;

  /// No description provided for @averageDuration.
  ///
  /// In en, this message translates to:
  /// **'Average duration'**
  String get averageDuration;

  /// No description provided for @personalProfiles.
  ///
  /// In en, this message translates to:
  /// **'Personal profiles'**
  String get personalProfiles;

  /// No description provided for @addProfile.
  ///
  /// In en, this message translates to:
  /// **'Add profile'**
  String get addProfile;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Profile name'**
  String get profileName;

  /// No description provided for @noProfiles.
  ///
  /// In en, this message translates to:
  /// **'No profiles yet. Add one or start a game.'**
  String get noProfiles;

  /// No description provided for @noGameHistory.
  ///
  /// In en, this message translates to:
  /// **'No completed games for this profile.'**
  String get noGameHistory;

  /// No description provided for @noWinner.
  ///
  /// In en, this message translates to:
  /// **'No winner'**
  String get noWinner;

  /// No description provided for @winnerNames.
  ///
  /// In en, this message translates to:
  /// **'Winner: {names}'**
  String winnerNames(String names);

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutes(int minutes);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min'**
  String durationHoursMinutes(int hours, int minutes);

  /// No description provided for @viewStatistics.
  ///
  /// In en, this message translates to:
  /// **'Game history'**
  String get viewStatistics;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'How to play'**
  String get rules;

  /// No description provided for @rulesTurnTitle.
  ///
  /// In en, this message translates to:
  /// **'Your turn'**
  String get rulesTurnTitle;

  /// No description provided for @rulesTurnBody.
  ///
  /// In en, this message translates to:
  /// **'Open a door, deal with what\'s behind it (fight, loot, or run), then optionally loot the room. Finish with \"End turn\" so the next player goes.'**
  String get rulesTurnBody;

  /// No description provided for @rulesCombatTitle.
  ///
  /// In en, this message translates to:
  /// **'Combat'**
  String get rulesCombatTitle;

  /// No description provided for @rulesCombatBody.
  ///
  /// In en, this message translates to:
  /// **'Compare total power. If you\'re stronger, press \"I can win\" - a countdown starts before it\'s locked in. If you\'re weaker, ask for help, run away, or accept the monster\'s Bad Stuff.'**
  String get rulesCombatBody;

  /// No description provided for @rulesInterventionTitle.
  ///
  /// In en, this message translates to:
  /// **'Intervening'**
  String get rulesInterventionTitle;

  /// No description provided for @rulesInterventionBody.
  ///
  /// In en, this message translates to:
  /// **'Any other player can intervene during the victory countdown by playing a card that changes the fight (a monster enhancer, a curse, help). Only the first intervention counts - the server rejects late ones.'**
  String get rulesInterventionBody;

  /// No description provided for @rulesEscapeTitle.
  ///
  /// In en, this message translates to:
  /// **'Running away'**
  String get rulesEscapeTitle;

  /// No description provided for @rulesEscapeBody.
  ///
  /// In en, this message translates to:
  /// **'Roll to escape. If you make it, the battle ends with no reward and no penalty. If you don\'t, the monster\'s Bad Stuff applies - usually you shrink back down to the table\'s minimum level.'**
  String get rulesEscapeBody;

  /// No description provided for @rulesIdentityTitle.
  ///
  /// In en, this message translates to:
  /// **'Race & class'**
  String get rulesIdentityTitle;

  /// No description provided for @rulesIdentityBody.
  ///
  /// In en, this message translates to:
  /// **'Humans have no race card and no special ability. Elves, Dwarves, Halflings and the expansion races each grant abilities from their card. Super Munchkin lets you hold two classes at once, and Half-Breed lets you hold two races - the app supports selecting more than one.'**
  String get rulesIdentityBody;

  /// No description provided for @rulesWinningTitle.
  ///
  /// In en, this message translates to:
  /// **'Winning'**
  String get rulesWinningTitle;

  /// No description provided for @rulesWinningBody.
  ///
  /// In en, this message translates to:
  /// **'The first munchkin to reach the table\'s maximum level (10 in the standard game) and defeat one more monster wins the game.'**
  String get rulesWinningBody;

  /// No description provided for @localPlayers.
  ///
  /// In en, this message translates to:
  /// **'Players on this device'**
  String get localPlayers;

  /// No description provided for @localPlayersHint.
  ///
  /// In en, this message translates to:
  /// **'Add players who will take turns using this device. They do not need their own phones.'**
  String get localPlayersHint;

  /// No description provided for @addLocalPlayer.
  ///
  /// In en, this message translates to:
  /// **'Add player'**
  String get addLocalPlayer;

  /// No description provided for @duplicatePlayerName.
  ///
  /// In en, this message translates to:
  /// **'Player names must be unique.'**
  String get duplicatePlayerName;

  /// No description provided for @localPlayerTag.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get localPlayerTag;

  /// No description provided for @addLocalPlayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a player on this device'**
  String get addLocalPlayerTitle;

  /// No description provided for @playerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Player name'**
  String get playerNameLabel;

  /// No description provided for @gameWinnerBadge.
  ///
  /// In en, this message translates to:
  /// **'Winner'**
  String get gameWinnerBadge;

  /// No description provided for @gameWinnerAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'{name} reached level {level} and won the game!'**
  String gameWinnerAnnouncement(String name, int level);

  /// No description provided for @endGameNow.
  ///
  /// In en, this message translates to:
  /// **'End the game'**
  String get endGameNow;

  /// No description provided for @peakLevelCaption.
  ///
  /// In en, this message translates to:
  /// **'Peak this game: {level}'**
  String peakLevelCaption(int level);

  /// No description provided for @openDoor.
  ///
  /// In en, this message translates to:
  /// **'Open a door'**
  String get openDoor;

  /// No description provided for @openDoorHint.
  ///
  /// In en, this message translates to:
  /// **'Deal with whatever is behind it, then start a battle or end your turn.'**
  String get openDoorHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
