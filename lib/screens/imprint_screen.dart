import 'package:flutter/material.dart';
import '../constants/box_size.dart';
import '../constants/padding.dart';
import '../widgets/navigation_drawer.dart' as nav;

class ImprintScreen extends StatelessWidget {
  const ImprintScreen({super.key});

  static const String id = 'imprint_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const nav.NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Impressum'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            kPadding,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Entwickler der Applikation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Manuel Struzyna',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Verein',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Sportvereinigung Durchhausen e.V.',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Sitz',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    '78591 Durchhausen (Kreis Tuttlingen)',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Vereinsregister',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'eingetragen im Vereinsregister am Amtsgericht Stuttgart (VR 460384),',
                  ),
                  Text(
                    'vormals Amtsgericht Spaichingen (VR 332)',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Anschrift',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Dorfstraße 78, 78591 Durchhausen',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Telefon',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    '07464/4015',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'E-Mail-Adresse',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'info@sv-durchhausen.de',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Vorstand im Sinne des §26 BGB',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Harald Bury\nOliver Utz\nThomas Merz',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Steuer-Nummer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    '21105/032526',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Umsatzsteuer-Identnummer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'DE142941554',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'V.i.S.d. TMG',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Harald Bury',
                  ),
                  Text(
                    'Dorfstraße 78, 78591 Durchhausen',
                  ),
                  Text(
                    'Tel.: 07464/4015',
                  ),
                  Text(
                    'E-Mail: bury@tixit.de',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Datenschutzbeauftragter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Daniel Dreher',
                  ),
                  Text(
                    'Aschenreutestraße 8, 78591 Durchhausen',
                  ),
                  Text(
                    'Tel.: 07464/575',
                  ),
                  Text(
                    'E-Mail: dd@sv-durchhausen.de',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Datenschutzerklärung',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Wir erheben, verwenden und speichern Ihre personenbezogenen Daten ausschließlich im Rahmen der Bestimmungen des Bundesdatenschutzgesetzes der Bundesrepublik Deutschland. Nachfolgend unterrichten wir Sie über Art, Umfang und Zweck der Datenerhebung und Verwendung.',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Erhebung und Verarbeitung von Daten',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Jeder Zugriff auf unsere Internetseite und jeder Abruf einer auf dieser Website hinterlegten Datei werden protokolliert. Die Speicherung dient internen systembezogenen und statistischen Zwecken. Protokolliert werden: Name der abgerufenen Datei, Datum und Uhrzeit des Abrufs, übertragene Datenmenge, Meldung über erfolgreichen Abruf, Webbrowser und anfragende Domain. Zusätzlich werden die IP Adressen der anfragenden Rechner protokolliert. Weitergehende personenbezogene Daten werden nur erfasst, wenn der Nutzer der Website und/oder Kunde Angaben freiwillig, etwa im Rahmen einer Anfrage oder Registrierung oder zum Abschluss eines Vertrages oder über die Einstellungen seines Browsers tätigt.\nUnsere Internetseite verwendet Cookies. Ein Cookie ist eine Textdatei, die beim Besuch einer Internetseite verschickt und auf der Festplatte des Nutzer der Website und/oder Kunden zwischengespeichert wird. Wird der entsprechende Server unserer Webseite erneut vom Nutzer der Website und/oder Kunden aufgerufen, sendet der Browser des Nutzers der Website und/oder des Kunden den zuvor empfangenen Cookie wieder zurück an den Server. Der Server kann dann die durch diese Prozedur erhaltenen Informationen auf verschiedene Arten auswerten. Durch Cookies können z. B. Werbeeinblendungen gesteuert oder das Navigieren auf einer Internetseite erleichtert werden. Wenn der Nutzer der Website und/oder Kunde die Nutzung von Cookies unterbinden will, kann er dies durch lokale Vornahme der Änderungen seiner Einstellungen in dem auf seinem Computer verwendeten Internetbrowser, also dem Programm zum Öffnen und Anzeigen von Internetseiten (z.B. Internet Explorer, Mozilla Firefox, Opera oder Safari) tun.',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Nutzung und Weitergabe personenbezogener Daten',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Soweit der Nutzer unserer Webseite personenbezogene Daten zur Verfügung gestellt hat, verwenden wir diese nur zur Beantwortung von Anfragen des Nutzers der Website und/oder Kunden, zur Abwicklung mit dem Nutzer der Website und/oder Kunden geschlossener Verträge und für die technische Administration. Personenbezogene Daten werden von uns an Dritte nur weitergegeben oder sonst übermittelt, wenn dies zum Zwecke der Vertragsabwicklung oder zu Abrechnungszwecken erforderlich ist oder der Nutzer der Website und/oder Kunde zuvor eingewilligt hat. Der Nutzer der Website und/oder Kunde hat das Recht, eine erteilte Einwilligung mit Wirkung für die Zukunft jederzeit zu widerrufen.\n\nDie Löschung der gespeicherten personenbezogenen Daten erfolgt, wenn der Nutzer der Website und/oder Kunde die Einwilligung zur Speicherung widerruft, wenn ihre Kenntnis zur Erfüllung des mit der Speicherung verfolgten Zwecks nicht mehr erforderlich ist oder wenn ihre Speicherung aus sonstigen gesetzlichen Gründen unzulässig ist. Daten für Abrechnungszwecke und buchhalterische Zwecke werden von einem Löschungsverlangen nicht berührt.',
                  ),
                  SizedBox(
                    height: kBoxHeight,
                  ),
                  Text(
                    'Auskunftsrecht',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Auf schriftliche Anfrage informieren wir den Nutzer der Website und/oder den Kunden über die zu seiner Person gespeicherten Daten. Die Anfrage ist an unsere im Impressum der Webseite angegebene Adresse zu richten.\n\nFür weitere Fragen zum Datenschutz stehen wir Ihnen gerne unter E-Mail datenschutz@sv-durchhausen.de zur Verfügung.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
