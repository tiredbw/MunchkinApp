import 'package:flutter/material.dart';

import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';

const Map<MunchkinRace, IconData> raceIcons = <MunchkinRace, IconData>{
  MunchkinRace.human: Icons.person,
  MunchkinRace.elf: Icons.forest,
  MunchkinRace.dwarf: Icons.terrain,
  MunchkinRace.halfling: Icons.hiking,
  MunchkinRace.orc: Icons.whatshot,
  MunchkinRace.gnome: Icons.face,
  MunchkinRace.centaur: Icons.directions_run,
  MunchkinRace.lizardGuy: Icons.pets,
};

const Map<MunchkinClass, IconData> classIcons = <MunchkinClass, IconData>{
  MunchkinClass.warrior: Icons.gavel,
  MunchkinClass.wizard: Icons.auto_fix_high,
  MunchkinClass.cleric: Icons.favorite,
  MunchkinClass.thief: Icons.visibility_off,
  MunchkinClass.bard: Icons.music_note,
  MunchkinClass.ranger: Icons.explore,
};

String raceLabel(AppLocalizations l10n, MunchkinRace race) => switch (race) {
  MunchkinRace.human => l10n.raceHuman,
  MunchkinRace.elf => l10n.raceElf,
  MunchkinRace.dwarf => l10n.raceDwarf,
  MunchkinRace.halfling => l10n.raceHalfling,
  MunchkinRace.orc => l10n.raceOrc,
  MunchkinRace.gnome => l10n.raceGnome,
  MunchkinRace.centaur => l10n.raceCentaur,
  MunchkinRace.lizardGuy => l10n.raceLizardGuy,
};

String classLabel(AppLocalizations l10n, MunchkinClass value) =>
    switch (value) {
      MunchkinClass.warrior => l10n.classWarrior,
      MunchkinClass.wizard => l10n.classWizard,
      MunchkinClass.cleric => l10n.classCleric,
      MunchkinClass.thief => l10n.classThief,
      MunchkinClass.bard => l10n.classBard,
      MunchkinClass.ranger => l10n.classRanger,
    };
