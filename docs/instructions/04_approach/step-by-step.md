# Vorgehen
Durchdenke zuerst die einzelnen Schritte und stelle sie mir vor. Gehe erst zum nächsten Schritt, wenn ich es dir sage.

1. Lass uns zuerst gemeinsam die Datenbank entwerfen. Die Datenbank soll unter dem Verzeichnis /database in der Datei schema.sql abgespeichert werden.
2. Erstelle ein Framework, dass die Anfragen entgegen nimmt und ausgibt. Das Framework soll aus Controllern und Models bestehen. Angaben für Datenbanken und Configs sind in einer .env Datei abgelegt.
3. Um eine gute Dokumentation zu haben, versehe jede Funktion mit einem Doc-Block
4. Sicherheit ist wichtig. Validiere alle Eingabe-Parameter und sichere die Anwednung gegen Angriffe ab. Stelle mir das Sicherheitskonzept vor.
5. Erstelle die Routen und die Mehtoden für GET, POST und DELETE
6. Erstelle 100 Beispiel-Daten als Initial-Seed-SQL für den Test und lege das SQL-Skript unter /database ab.
7. Erstelle health und ready-Checks