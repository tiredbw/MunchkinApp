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
  String get raiseLevel => 'Повысить уровень';

  @override
  String get rollDice => 'Бросить D6';

  @override
  String get physicalDice => 'Бросьте реальный кубик';

  @override
  String get endGame => 'Завершить партию';

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
  String get waitingForActivePlayer => 'Ожидание активного игрока';

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
  String get levelRewardClaimed => 'Уровень за победу получен';

  @override
  String get recordPhysicalRoll => 'Записать реальный бросок';

  @override
  String get useCheatDie => 'Читерский кубик';

  @override
  String get appealCheatDie => 'Оспорить читерский кубик';

  @override
  String get diceAppealPending => 'Ожидание решения ведущего по апелляции';

  @override
  String get restoreOriginalRoll => 'Вернуть исходный';

  @override
  String get keepCheatRoll => 'Оставить результат';

  @override
  String get originalRoll => 'Исходный бросок';

  @override
  String get cheatDieApplied => 'применён читерский кубик';

  @override
  String get increaseLevel => 'Повысить уровень';

  @override
  String get decreaseLevel => 'Понизить уровень';

  @override
  String get showInvite => 'Показать приглашение';

  @override
  String get continueGame => 'Продолжить партию';

  @override
  String get continueGameFailed =>
      'Ведущий недоступен. Повторите попытку или отсканируйте новый QR-код.';

  @override
  String get statsLockedDuringBattle =>
      'Во время боя нельзя менять уровень и силу.';

  @override
  String get controlProfile => 'Переключить игрока';

  @override
  String playingAs(String name) {
    return 'Вы играете за: $name';
  }

  @override
  String controlRequested(String name) {
    return 'Ведущий предлагает управлять игроком $name с этого устройства.';
  }

  @override
  String get accept => 'Принять';

  @override
  String get decline => 'Отклонить';

  @override
  String get assignDevice => 'Передать на устройство';

  @override
  String get revokeAssignment => 'Отозвать передачу';

  @override
  String get pendingAssignment => 'Ожидает подтверждения';

  @override
  String controlledOnDevice(String name) {
    return 'На устройстве игрока $name';
  }

  @override
  String get chooseDevice => 'Выберите устройство';

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
  String get battleAlreadyPlayed =>
      'В этом ходу уже был бой. Завершите ход, чтобы начать следующий.';

  @override
  String get localPlayers => 'Игроки на этом устройстве';

  @override
  String get localPlayersHint =>
      'Добавьте игроков, которые будут по очереди играть на устройстве ведущего. Телефоны им не нужны.';

  @override
  String get addLocalPlayer => 'Добавить игрока';

  @override
  String get duplicatePlayerName => 'Имена игроков не должны повторяться.';
}
