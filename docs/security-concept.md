# Sicherheitskonzept — Ratings API

Dieses Dokument beschreibt die im Projekt umgesetzten Schutzmaßnahmen und offene Punkte. Es ergänzt die Anforderungen aus `/docs/instructions`.

## 1. Eingabevalidierung

- Alle JSON-Request-Bodies für `POST`-Routen werden gegen die Dateien unter [`schemas/`](../schemas/) validiert (JSON-Schema-kompatible Regeln).
- Pfadparameter (`store`, `productId`, `ratingId`) werden serverseitig gegen feste Muster geprüft (vierstelliger Shop, erlaubte Produkt-ID-Zeichen, positive numerische Rating-ID).
- Query-Parameter `source` wird auf die erlaubten ENUM-Werte begrenzt oder als `NULL` gespeichert, wenn er fehlt oder leer ist.

## 2. SQL-Injection

- Alle Datenbankzugriffe laufen über **PDO Prepared Statements** mit Platzhaltern. Es werden keine dynamischen SQL-Fragmente aus Roh-User-Input zusammengebaut.

## 3. Authentifizierung und Autorisierung

- Öffentlich (ohne Schlüssel): `GET /api/ratings/...` (Lesen freigegebener Bewertungen), `POST /api/ratings/...` (neue Bewertung), `GET /health`, `GET /ready`.
- Geschützt: `POST .../approve`, `POST .../reject`, `DELETE /api/ratings/{id}`. Zugriff nur mit gültigem **`MODERATION_API_KEY`** aus der Umgebung (`.env`), über `Authorization: Bearer <Schlüssel>` oder `X-API-Key: <Schlüssel>`.
- Fehlender oder falscher Schlüssel → HTTP **401** mit Code `UNAUTHORIZED`.
- **Hinweis:** Es gibt keine differenzierten Rollen (nur ein geteilter Moderationsschlüssel). Feinrechte (z. B. pro Mitarbeiter) sind nicht Teil der Spezifikation und bleiben ein mögliches Ausbau-Thema.

## 4. Transport und Geheimnisse

- TLS-Terminierung liegt typischerweise vor dem PHP-Prozess (Reverse Proxy / Hosting). Die Anwendung setzt TLS nicht selbst.
- `.env` mit DB-Zugang und `MODERATION_API_KEY` gehört **nicht** ins Versionsarchiv (siehe `.gitignore`).

## 5. Verfügbarkeit und Missbrauch

- Rate-Limiting und Bot-Schutz sind in den `/docs` nicht gefordert und sind **nicht** implementiert. Empfehlung für Produktion: Limits auf Reverse-Proxy-Ebene oder WAF.
- `health` / `ready` dienen Betriebsüberwachung; `ready` prüft die Datenbankverbindung.

## 6. Domain-Events

- Ereignisse (`rating.created`, `rating.approved`, `rating.rejected`, `rating.deleted`) werden minimal als **strukturierte Zeilen ins PHP-Error-Log** geschrieben (kein externer Versand). Anbindung an Queues oder Webhooks kann später ergänzt werden, ohne die API-Verträge zu ändern.

## 7. Fehlerbehandlung

- Fehlerantworten nutzen **standardisierte Codes** (`RATING_NOT_FOUND`, `PRODUCT_NOT_FOUND`, `INVALID_REQUEST`, `UNAUTHORIZED`, `INTERNAL_ERROR`) statt freier Texte als alleinige Fehlerquelle.
- Unerwartete Exceptions führen zu HTTP **500** und Code `INTERNAL_ERROR`; Details werden nicht an Clients geleakt (nur serverseitiges Logging).
