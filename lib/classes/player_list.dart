import 'Player.dart';

class PlayerList {
  List<Player> playerList = [
    Player(
        profilePicture:
            'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerbilder%2FM%C3%BCller%2C%20Dominik.PNG?alt=media&token=dad99384-2507-4b1b-9da7-2507f5fa3034',
        forename: 'Dominik',
        surname: 'Müller',
        appearances: 28,
        appearanceMinutes: 2368,
        goals: 0),
    Player(
        profilePicture:
            'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerbilder%2FPatzak%2C%20Andreas.PNG?alt=media&token=473932e8-8e2f-4401-ac15-5eeeac3ca88a',
        forename: 'Patzak',
        surname: 'Andreas',
        appearances: 25,
        appearanceMinutes: 1971,
        goals: 7),
    Player(
        profilePicture:
            'https://firebasestorage.googleapis.com/v0/b/sgm-duguwe.appspot.com/o/Spielerbilder%2FSchmid%2C%20Dominik.PNG?alt=media&token=b64073a2-4a09-406b-bac3-2b22312d27de',
        forename: 'Schmid',
        surname: 'Dominik',
        appearances: 24,
        appearanceMinutes: 1653,
        goals: 3),
  ];
}
