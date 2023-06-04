import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  // Sign up user
  static Future<User?> signUp(
      {required String userEmail,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      displayErrorCode(context, e.toString());
    }
  }

  // Sign in user
  static Future<User?> signIn(
      {required String userEmail,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      displayErrorCode(context, e.toString());
    }
    return null;
  }

  // Sign out user
  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      displayErrorCode(context, e.toString());
    }
  }

  // Get current user
  static User? getUser() {
    try {
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }

  // Display possible error code from Firebase when registration or login has failed
  static void displayErrorCode(context, String errorCode) {
    String errorMessage = '';

    switch (errorCode) {
      case 'auth/claims-too-large':
        errorMessage =
            'Die für setCustomUserClaims() bereitgestellte Anspruchsnutzlast überschreitet die maximal zulässige Größe von 1000 Bytes.';
        break;
      case 'auth/email-already-exists':
        errorMessage =
            'Die angegebene E-Mail-Adresse wird bereits von einem bestehenden Benutzer verwendet. Jeder Benutzer muss eine eindeutige E-Mail-Adresse haben.';
        break;
      case 'auth/id-token-expired':
        errorMessage = 'Das bereitgestellte Firebase-ID-Token ist abgelaufen.';
        break;
      case 'auth/id-token-revoked':
        errorMessage = 'Das Firebase-ID-Token wurde widerrufen.';
        break;
      case 'auth/insufficient-permission':
        errorMessage =
            'Die zum Initialisieren des Admin SDK verwendeten Anmeldeinformationen verfügen nicht über die Berechtigung, auf die angeforderte Authentifizierungsressource zuzugreifen. Unter Einrichten eines Firebase-Projekts finden Sie eine Dokumentation zum Generieren von Anmeldeinformationen mit den entsprechenden Berechtigungen und deren Verwendung zum Authentifizieren der Admin-SDKs.';
        break;
      case 'auth/internal-error':
        errorMessage =
            'Der Authentifizierungsserver hat beim Versuch, die Anfrage zu verarbeiten, einen unerwarteten Fehler festgestellt. Die Fehlermeldung sollte die Antwort des Authentifizierungsservers mit zusätzlichen Informationen enthalten. Wenn der Fehler weiterhin besteht, melden Sie das Problem bitte unserem Bug Report -Supportkanal.';
        break;
      case 'auth/invalid-argument':
        errorMessage =
            'Einer Authentifizierungsmethode wurde ein ungültiges Argument bereitgestellt. Die Fehlermeldung sollte zusätzliche Informationen enthalten.';
        break;
      case 'auth/invalid-claims':
        errorMessage =
            'Die für setCustomUserClaims() bereitgestellten benutzerdefinierten Anspruchsattribute sind ungültig.';
        break;
      case 'auth/invalid-continue-uri':
        errorMessage =
            'Die Fortsetzungs-URL muss eine gültige URL-Zeichenfolge sein.';
        break;
      case 'auth/invalid-creation-time':
        errorMessage =
            'Die Erstellungszeit muss eine gültige UTC-Datumszeichenfolge sein.';
        break;
      case 'auth/invalid-credential':
        errorMessage =
            'Die zum Authentifizieren der Admin-SDKs verwendeten Anmeldeinformationen können nicht zum Ausführen der gewünschten Aktion verwendet werden. Bestimmte Authentifizierungsmethoden wie createCustomToken() “ und verifyIdToken() erfordern, dass das SDK mit einem Zertifikatsnachweis initialisiert wird, im Gegensatz zu einem Aktualisierungstoken oder einem standardmäßigen Anwendungsnachweis. Unter Initialisieren des SDK finden Sie eine Dokumentation zum Authentifizieren der Admin-SDKs mit einem Zertifikatsnachweis.';
        break;
      case 'auth/invalid-disabled-field':
        errorMessage =
            'Der angegebene Wert für die disabled Benutzereigenschaft ist ungültig. Es muss ein boolescher Wert sein.';
        break;
      case 'auth/invalid-display-name':
        errorMessage =
            'Der angegebene Wert für die Benutzereigenschaft displayName ist ungültig. Es muss eine nicht leere Zeichenfolge sein.';
        break;
      case 'auth/invalid-dynamic-link-domain':
        errorMessage =
            'Die bereitgestellte Domäne mit dynamischem Link ist für das aktuelle Projekt nicht konfiguriert oder autorisiert.';
        break;
      case 'auth/invalid-email	':
        errorMessage =
            'Der angegebene Wert für die email Benutzereigenschaft ist ungültig. Es muss sich um eine Zeichenfolgen-E-Mail-Adresse handeln.';
        break;
      case 'auth/invalid-email-verified':
        errorMessage =
            'Der angegebene Wert für die Benutzereigenschaft emailVerified ist ungültig. Es muss ein boolescher Wert sein.';
        break;
      case 'auth/invalid-hash-algorithm':
        errorMessage = 'Die Hash-Blockgröße muss eine gültige Zahl sein.';
        break;
      case 'auth/invalid-hash-block-size':
        errorMessage =
            'Der Hash-Algorithmus muss mit einer der Zeichenfolgen in der Liste der unterstützten Algorithmen übereinstimmen.';
        break;
      case 'auth/invalid-hash-derived-key-length':
        errorMessage = 'Die Hash-Blockgröße muss eine gültige Zahl sein.';
        break;
      case 'auth/invalid-hash-key':
        errorMessage = 'Der Hash-Schlüssel muss ein gültiger Byte-Puffer sein.';
        break;
      case 'auth/invalid-hash-memory-cost':
        errorMessage = 'Die Hash-Speicherkosten müssen eine gültige Zahl sein.';
        break;
      case 'auth/invalid-hash-parallelization':
        errorMessage = 'Die Hash-Parallelisierung muss eine gültige Zahl sein.';
        break;
      case 'auth/invalid-hash-rounds':
        errorMessage = 'Die Hash-Runden müssen eine gültige Zahl sein.';
        break;
      case 'auth/invalid-hash-salt-separator':
        errorMessage =
            'auth/Das Salt-Separatorfeld des Hashalgorithmus muss ein gültiger Bytepuffer sein.';
        break;
      case 'auth/invalid-id-token':
        errorMessage =
            'Das bereitgestellte ID-Token ist kein gültiges Firebase-ID-Token.';
        break;
      case 'auth/invalid-last-sign-in-time':
        errorMessage =
            'Die letzte Anmeldezeit muss eine gültige UTC-Datumszeichenfolge sein.';
        break;
      case 'auth/invalid-page-token':
        errorMessage =
            'Das bereitgestellte Token für die nächste Seite in listUsers() ist ungültig. Es muss eine gültige, nicht leere Zeichenfolge sein.';
        break;
      case 'auth/invalid-password':
        errorMessage =
            'Der angegebene Wert für die Benutzereigenschaft password ist ungültig. Es muss eine Zeichenfolge mit mindestens sechs Zeichen sein.';
        break;
      case 'auth/invalid-password-hash':
        errorMessage = 'Der Passwort-Hash muss ein gültiger Byte-Puffer sein.';
        break;
      case 'auth/invalid-password-salt':
        errorMessage = 'Das Passwort-Salt muss ein gültiger Byte-Puffer sein.';
        break;
      case 'auth/invalid-phone-number':
        errorMessage =
            'Der angegebene Wert für phoneNumber ist ungültig. Es muss sich um eine nicht leere E.164-standardkonforme Kennungszeichenfolge handeln.';
        break;
      case 'auth/invalid-photo-url':
        errorMessage =
            'Der angegebene Wert für die Benutzereigenschaft ist ungültig. Es muss eine String-URL sein.';
        break;
      case 'auth/invalid-provider-data':
        errorMessage =
            'Die providerData muss ein gültiges Array von UserInfo-Objekten sein.';
        break;
      case 'auth/invalid-provider-id':
        errorMessage =
            'Die Anbieter-ID muss eine gültige unterstützte Anbieterkennungszeichenfolge sein.';
        break;
      case 'auth/invalid-oauth-responsetype':
        errorMessage =
            'Nur genau ein OAuth responseType sollte auf true gesetzt werden.';
        break;
      case 'auth/invalid-session-cookie-duration':
        errorMessage =
            'Die Sitzungs-Cookie-Dauer muss eine gültige Zahl in Millisekunden zwischen 5 Minuten und 2 Wochen sein.';
        break;
      case 'auth/invalid-uid':
        errorMessage =
            'Die bereitgestellte uid muss eine nicht leere Zeichenfolge mit höchstens 128 Zeichen sein.';
        break;
      case 'auth/invalid-user-import':
        errorMessage = 'Der zu importierende Benutzerdatensatz ist ungültig.';
        break;
      case 'auth/maximum-user-count-exceeded':
        errorMessage =
            'Die maximal zulässige Anzahl von zu importierenden Benutzern wurde überschritten.';
        break;
      case 'auth/missing-android-pkg-name':
        errorMessage =
            'Ein Android-Paketname muss angegeben werden, wenn die Android-App installiert werden muss.';
        break;
      case 'auth/missing-continue-uri':
        errorMessage =
            'In der Anforderung muss eine gültige Fortsetzungs-URL angegeben werden.';
        break;
      case 'auth/missing-hash-algorithm':
        errorMessage =
            'Das Importieren von Benutzern mit Passwort-Hashes erfordert die Bereitstellung des Hash-Algorithmus und seiner Parameter.';
        break;
      case 'auth/missing-ios-bundle-id':
        errorMessage = 'Der Anfrage fehlt eine Bundle-ID.';
        break;
      case 'auth/missing-uid':
        errorMessage =
            'Für die aktuelle Operation ist eine uid Kennung erforderlich.';
        break;
      case 'auth/missing-oauth-client-secret':
        errorMessage =
            'Der OAuth-Konfigurationsclientschlüssel ist erforderlich, um den OIDC-Codefluss zu aktivieren.';
        break;
      case 'auth/operation-not-allowed':
        errorMessage =
            'Der bereitgestellte Anmeldeanbieter ist für Ihr Firebase-Projekt deaktiviert. Aktivieren Sie es im Abschnitt Anmeldemethode der Firebase- Konsole.';
        break;
      case 'auth/phone-number-already-exists':
        errorMessage =
            'Die phoneNumber wird bereits von einem bestehenden Benutzer verwendet. Jeder Benutzer muss eine eindeutige phoneNumber haben.';
        break;
      case 'auth/project-not-found':
        errorMessage =
            'Für die zum Initialisieren der Admin-SDKs verwendeten Anmeldedaten wurde kein Firebase-Projekt gefunden. Unter Einrichten eines Firebase-Projekts finden Sie eine Dokumentation zum Generieren von Anmeldeinformationen für Ihr Projekt und zum Authentifizieren der Admin-SDKs.';
        break;
      case 'auth/reserved-claims':
        errorMessage =
            'Ein oder mehrere benutzerdefinierte Benutzeransprüche, die für setCustomUserClaims() bereitgestellt werden, sind reserviert. Beispielsweise sollten OIDC- spezifische Ansprüche wie (sub, iat, iss, exp, aud, auth_time usw.) nicht als Schlüssel für benutzerdefinierte Ansprüche verwendet werden.';
        break;
      case 'auth/session-cookie-expired':
        errorMessage =
            'Das bereitgestellte Firebase-Sitzungscookie ist abgelaufen.';
        break;
      case 'auth/session-cookie-revoked':
        errorMessage = 'Das Firebase-Sitzungscookie wurde widerrufen.';
        break;
      case 'auth/uid-already-exists':
        errorMessage =
            'Die bereitgestellte uid wird bereits von einem vorhandenen Benutzer verwendet. Jeder Benutzer muss eine eindeutige uid haben.';
        break;
      case 'auth/unauthorized-continue-uri':
        errorMessage =
            'Die Domain der Continue-URL ist nicht auf der Whitelist. Setzen Sie die Domäne in der Firebase-Konsole auf die Whitelist.';
        break;
      case 'auth/user-not-found':
        errorMessage =
            'Es gibt keinen vorhandenen Benutzerdatensatz, der der angegebenen Kennung entspricht.';
        break;
      default:
        errorMessage = 'Unbekannter Fehler.';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
        ),
      ),
    );
  }
}
