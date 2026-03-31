# API

## Verantwortlichkeiten
- Bewertungen je Shop und Produkt anzeigen
- Neue Bewertung abgeben 
- Bewertung um Freigaben und Gründe aktualisieren
- Bewertung löschen

APIs:
- GET /api/ratings/{store}/{productId}
```
{
	"data": {
		"ratings": [
			{
				"id": 66778,
				"star": 4,
				"text": "Toller Artikel",
				"author": "Simon G.",
				"created": "2019-03-13 10:48:00",
			},
			...
		],
		"distribution": {
			1: 0,
			2: 1,
			3: 3,
			4: 20,
			5: 25
		},
		"stars": 4.9
	}
}
```
- POST /api/ratings/{store}/{productId}
- POST /api/ratings/{ratingId}/approve
- POST /api/ratings/{ratingId}/reject
- DELETE /api/ratings/{ratingId}

Events:
- rating.created
- rating.approved
- rating.rejected
- rating.deleted

## Namenskonventionen

- Ressourcen plural:
  /api/ratings

## Aggregationen
Bei GET /api/ratings/{store}/{productId} sollen die Aggregationen wie Übersicht über alle Bewertungen sternebasiert und der Durchschnitt live berechnet werden.

## Input-Validierung
- ALLE Inputs validieren
- JSON Schema nutzen
- Keine impliziten Annahmen

## Dokumentation
- Erstelle eine OpenAPI-Dokumenation im yaml-Format
- Halte die dokumentation nach jeder Änderung aktuell

## query-Strings
- über den Parameter source kann der Ursprung der Anfrage (Quellsystem - SHOP, MAIL, INTRANET) mitgegeben werden. Wenn er fehlt wird der Urspung auf NULL gesetzt.

## Payload für neue Bewertung
```
{
  "rating": 5,
  "author": "Max Mustermann",
  "text": "Super Produkt!"
}
```

## Payload für Freigabe
```
{
  "status": "APPROVED",
  "criteria": 2
}
```

## Payload für Ablehnung
```
{
  "status": "NOT_APPROVED",
  "reason": 2
}
```

## Response-Format
```
{
  "data": {
...
  },
  "error": {
...
  }
}
```

## Status-Codes für Responses
- 200 OK
- 201 Created
- 204 No Content (für DELETE)

## Error Handling

- KEINE freien Error-Strings
- IMMER standardisierte Codes
- HTTP Status Codes korrekt verwenden:
  - 400 → Validation
  - 401 → Unauthorized
  - 403 → Forbidden
  - 404 → Not Found
  - 500 → Internal Error

## Rating Errors
- RATING_NOT_FOUND
- PRODUCT_NOT_FOUND
- INVALID_REQUEST

Beispiel:
```
{
  "data" : null,
  "error": {
    "code": "RATING_NOT_FOUND",
    "message": "Rating not found",
    "details": {
      "id": "123456"
    }
  }
}
```