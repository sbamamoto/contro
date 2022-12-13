# Getting Started

Eine auf das Wesentlichste reduzierte hackerstyle Homeautomation Plattform.

## Die Einrichtung

Das System läuft mit Grails 4.0.3 auf Postgres. Also müssen diese Software auf dem System vor installiert sein. Bei mir läuft das Ganze mit Raspian Buster auf einem Raspberry 3b.

### Datenbank einrichten

```bash
sudo apt get install postregsql
sudo -u postgres createuser contro
sudo -u postgres createdb -O contro contro
sudo -u postgres psql contro -c "alter user contro with encrypted password 'contro';"
```

Damit ist die Datenbank und der Benutzer eingerichtet. Ich habe als Passwort der Einfachheit halber *contro* verwendet das sollte man natürlich bei einer aktiven Instanz nicht tun und ein sicheres Passwort wählen.

Das Datenbankschema legt contro beim ersten Start automatisch an.

### Contro einrichten

# Architektur

Es existieren zwei unterschiedliche Komponenten: Sensoren und Aktoren. Aktoren sind Komponenten, die eine Aktion auslösen können. Typische Aktoren sind Schaltsteckdosen, Rolomotoren, Heizungsthermostate oder smarte Leuchtmittel. Sensoren sind Komponenten die Werte liefern. Dies sind Thermometer, Helligkeitsmesser, Bewegungsmelder oder Schalter.

Sensoren und Aktoren können in einem Gerät zusammengefasst sein. So liefern viele Heizungsthermostate nicht nur die eingestellte Solltemperatur, sondern auch den die von einem Thermometer im Thermostat gemessene Temperatur. Einige Thermostate sind also sowohl Autor, als auch Sensor.

Sensoren werden ebenfalls in zwei Gruppen eingeteilt: aktive und passive Sensoren. Aktive Sensoren melden Werte auf Grund eines Ereignisses oder zyklisch, also in einem bestimmten Zeitintervall. Ein passiver Sensor hingegen liefert Daten nur auf Anfrage eines anderen Systems. Bewegungsmelder sind aktive Sensoren, die Informationen liefern, sobald jemand oder etwas in den Erfassungsbereich des Sensors eingetreten ist. Regenmengensensoren müssen angefragt werden und sind somit passive Sensoren.

Aktoren werden in Contro durch die folgenden Elemente und ihren Eigenschaften bestimmt:

- Device
  Das Device oder Gerät ist die Klammer in der sich alle Bestandteile des jeweiligen Aktors gespeichert sind. Darüberhinaus enthält das Gerät den aktuellen Status, einen Namen und eine Beschreibung.
- DeviceType
  Jede Device besitzt genau einen DeviceType. Der Gerätetyp gibt an,
- Ability
- Processor
