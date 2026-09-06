// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Настольный помощник';

  @override
  String get homeTagline => 'Локальный компаньон для настольных игр по Wi-Fi';

  @override
  String get createRoom => 'Создать комнату';

  @override
  String get joinRoom => 'Войти в комнату';

  @override
  String get restoreGame => 'Восстановить партию';

  @override
  String get yourName => 'Ваше имя';

  @override
  String get hostAddress => 'Адрес ведущего';

  @override
  String get port => 'Порт';

  @override
  String get pin => 'Шестизначный PIN';

  @override
  String get scanQr => 'Сканировать QR-код';

  @override
  String get players => 'Игроки';

  @override
  String get myCharacter => 'Мой персонаж';

  @override
  String get currentTurn => 'Текущий ход';

  @override
  String get level => 'Уровень';

  @override
  String get strength => 'Сила';

  @override
  String get totalPower => 'Общая мощь';

  @override
  String get identity => 'Раса и класс';

  @override
  String get trackRaceClass => 'Отмечать расу и класс';

  @override
  String get raceHuman => 'Человек';

  @override
  String get raceElf => 'Эльф';

  @override
  String get raceDwarf => 'Дворф';

  @override
  String get raceHalfling => 'Полурослик';

  @override
  String get raceOrc => 'Орк';

  @override
  String get raceGnome => 'Гном';

  @override
  String get raceCentaur => 'Кентавр';

  @override
  String get raceLizardGuy => 'Ящеролюд';

  @override
  String get classWarrior => 'Воин';

  @override
  String get classWizard => 'Маг';

  @override
  String get classCleric => 'Жрец';

  @override
  String get classThief => 'Вор';

  @override
  String get classBard => 'Бард';

  @override
  String get classRanger => 'Следопыт';

  @override
  String get closeLobby => 'Закрыть лобби';

  @override
  String get startGame => 'Начать игру';

  @override
  String get shuffle => 'Перемешать';

  @override
  String get endTurn => 'Завершить ход';

  @override
  String get startBattle => 'Начать бой';

  @override
  String get canWin => 'Могу победить';

  @override
  String get cannotWin => 'Не могу победить';

  @override
  String get intervene => 'Вмешаться';

  @override
  String get requestHelp => 'Попросить помощь';

  @override
  String get escape => 'Убегать';

  @override
  String get backToBattle => 'Вернуться к бою';

  @override
  String get finishBattle => 'Завершить бой';

  @override
  String get escapeOutcome => 'Побег удался?';

  @override
  String get survivedEscape => 'Удалось сбежать';

  @override
  String get diedInBattle => 'Погиб (Гадость)';

  @override
  String diedInBattleConfirm(int level) {
    return 'Монстр настиг вас своей Гадостью: уровень падает до $level. Подтвердить?';
  }

  @override
  String get raiseLevel => 'Повысить уровень';

  @override
  String get rollDice => 'Бросить D6';

  @override
  String get physicalDice => 'Бросьте реальный кубик';

  @override
  String get endGame => 'Завершить партию';

  @override
  String get endGameConfirm =>
      'Завершить партию для всех? Это действие необратимо.';

  @override
  String get connected => 'В сети';

  @override
  String get offline => 'Не в сети';

  @override
  String activePlayer(String name) {
    return 'Сейчас ходит: $name';
  }

  @override
  String get roomInvite => 'Приглашение в комнату';

  @override
  String get waitingForPlayers => 'Ожидание игроков';

  @override
  String get waitingForHost => 'Ожидание ведущего';

  @override
  String victoryCountdown(int seconds) {
    return 'Победа через $seconds с';
  }

  @override
  String diceResult(String name, int value) {
    return '$name: выпало $value';
  }

  @override
  String get settings => 'Настройки комнаты';

  @override
  String get virtualDice => 'Виртуальный кубик';

  @override
  String get realDice => 'Реальный кубик';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get retry => 'Повторить';

  @override
  String get leave => 'Покинуть комнату';

  @override
  String get youTag => 'Вы';

  @override
  String get error => 'Что-то пошло не так';

  @override
  String get manualJoin => 'Ввести данные вручную';

  @override
  String get roomId => 'ID комнаты';

  @override
  String get minimum => 'Минимум';

  @override
  String get maximum => 'Максимум';

  @override
  String get initial => 'Начальное';

  @override
  String get countdownSeconds => 'Отсчёт (секунды)';

  @override
  String get confirmOrder => 'Подтвердить порядок';

  @override
  String get reopenLobby => 'Открыть лобби снова';

  @override
  String get copyInvite => 'Скопировать приглашение';

  @override
  String get inviteCopied => 'Приглашение скопировано';

  @override
  String get interventionReceived => 'Игрок вмешался в бой';

  @override
  String get helpRequested => 'Активному игроку нужна помощь';

  @override
  String get battleWon => 'Бой выигран';

  @override
  String get escapingNow => 'Разыграйте побег за столом';

  @override
  String get finishEscape => 'Завершить побег';

  @override
  String get noSavedGame => 'Сохранённая партия не найдена';

  @override
  String get invalidForm => 'Проверьте введённые значения';

  @override
  String get gameEnded => 'Партия завершена';

  @override
  String get removePlayer => 'Удалить игрока';

  @override
  String get roomClosed => 'Подключение закрыто';

  @override
  String get resumeBattle => 'Продолжить бой';

  @override
  String get hostMustStayOpen =>
      'Приложение ведущего должно оставаться открытым';

  @override
  String get connectionError => 'Не удалось подключиться к ведущему';

  @override
  String get adPrivacyOptions => 'Настройки конфиденциальности рекламы';

  @override
  String get statistics => 'Статистика';

  @override
  String get gameHistory => 'История партий';

  @override
  String get gamesPlayed => 'Сыграно партий';

  @override
  String get wins => 'Победы';

  @override
  String get maxLevelReached => 'Максимальный уровень';

  @override
  String get averageDuration => 'Средняя длительность';

  @override
  String get personalProfiles => 'Персональные профили';

  @override
  String get addProfile => 'Добавить профиль';

  @override
  String get profileName => 'Имя профиля';

  @override
  String get noProfiles =>
      'Профилей пока нет. Добавьте профиль или начните игру.';

  @override
  String get noGameHistory => 'У этого профиля пока нет завершённых партий.';

  @override
  String get noWinner => 'Победителя нет';

  @override
  String winnerNames(String names) {
    return 'Победитель: $names';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get viewStatistics => 'История игр';
}
