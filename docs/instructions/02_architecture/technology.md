# Technologieentscheidungen

Allgemein: keine Frameworks, immer die aktuellste Version der Technologie einsetzen
Die Sprache der Anwendung ist ausschließlich Deutsch. Es braucht keine i8n.
Die Kommentare und Variablen-Bezeichnungen sollen aber durchgehend auf Englisch sein.

Character-Encoding: UTF-8

Backend: PHP
Datenbank: MySQL
APIs: REST
Testing: PHPUnit

# Architektur

Das Produkt soll in einer MACH-Architektur eingesetzt werden. Alle Funktionalität ist Headless umzusetzen. Die GUIs und Anzeige sind nicht teil des Projekts.

# Persistence

- Datenbank: MySQL
- Tabelle: ratings
- Primary Key: id
- Jede Tabelle hat immer ein created_at und updated_at-Feld zur Nachvollziehbarkeit
- Die Ausprägungen sind als ENUMs gespeichert
- Achte auf Indizes, damit die Daten schnell abgefragt werden können