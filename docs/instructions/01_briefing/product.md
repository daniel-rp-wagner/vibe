# Product Brief

## Ziel des Produkts
Im Online-Shop sollen Bewertungen der Kunden für die einzelnen Artikel angezeigt werden können. Das soll dem Nutzer einen schnellen Überblick zu Qualität und Vor- und Nachteilen eines Produkts ermöglichen. Dabei gibt es einen Bereich mit einer Übersicht über alle Bewertungen (Sternebasiert. Wie viele Bewertungen wurden je Stern vergeben. Z.B. 15 - 5 Sterne, 10 4 Sterne, 3 3 Sterne, etc.). Außerdem wird die Gesamtanzahl Bewertungen und eine Durchschnittsnote angezeigt, gerundet auf eine Nachkommastelle (z.B. 4,6). Die Bewertungen sind sortiert nach Aktualität. Die neueste Bewertung ist oben.

## Details
Jede Bewertung ist an ein Produkt geknüpft. Sie besteht aus einer Sterne-Angabe (Werte 1 bis 5), einem Autor-Feld (Freitext) und einem Bewertungsfeld (max. 1000 Zeichen). Zudem erfassen wir die E-Mail-Adresse, um den Kunden nach der Freigabe kontaktieren zu können (wenn z.B. eine Bewertung abgelehnt werden muss). Da die Bewertungen auf unterschiedlichen Wegen zu uns kommen können, erfassen wir auch die Quelle über einen URL-Parameter. Diese Quelle wird an der Bewertung gespeichert. Mögliche Ausprägungen sind: SHOP, MAIL, INTRANET.

## Rahmenbedingungen
Die Bewertungen werden von bereits registrierten Kunden in einem Shop abgegeben. Da wir eine Unternehmensgruppe sind, können die Bewertungen aber in mehreren Shop angezeigt werden.
Die Shops werden über eine vierstellige, numerische ID identifiziert, teilweise mit führenden Nullen. Zur Nachverfolgung möchte ich den Shop speichern, aus dem die Bewertung ursprünglich abgegeben wurde. Es ist möglich die Bewertung für alle Shops freizugeben oder nur für einzelne. Man kann auch mehrere Shops zur Freigabe auswählen. Bei der Abfrage sollen nur die Bewertungen ausgegeben werden, die für diesen Shop freigegeben sind.

Um unserer Verantwortung gerecht zu werden, müssen wir jede Bewertung vor der Veröffentlichung freigeben. Dabei prüft ein Mitarbeiter die Bewertungen inhaltlich und gibt sie frei oder lehnt sie ab. Die möglichen Status sind dabei: APPROVED, NOT_APPROVED, PENDING. Eine neue Bewertung ist zuerst einmal im Status "PENDING". Ausgegeben dürfen nur Bewertungen, die den Status "APPROVED" haben.

Zur Nachverfolgung muss ein Mitarbeiter die Ablehnungs-Gründe auswählen, warum eine Bewertung nicht freigegeben wurde. Dafür gibt es eine Liste an Ablehnungs-Gründen, die auch erweiterbar sein soll. Sie bestehen aus einer ID und einem Text, dem den Kunden angezeigt wird, z.B. "Vielen Dank für Ihre Bewertung. Diese bezog sich nicht auf das Produkt, sondern auf Beschädigungen oder Fehlfunktionen des Artikels. Wir haben dies zur Kenntnis genommen und werden den Sachverhalt prüfen."

Zusätzlich kann noch ein oder mehrere Kriterien für die Bewertung angegeben werden. Je nach Kriterium kann in der Folge ein interner E-Mail-Empfänger und ein Fachbereich informiert werden. Jedes Kriterium hat eine ID, eine Beschreibung und zur Zuordnung einen Fachbereich (Mögliche Ausprägungen: "EK" für Einkauf oder "KS" für Kundenservice) sowie eine E-Mail-Adresse.