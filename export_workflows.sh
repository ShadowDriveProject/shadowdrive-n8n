#!/bin/bash

# Setări API
API_URL="http://localhost:5678/rest"
USERNAME="admin"
PASSWORD="admin123"

# Obține tokenul de autentificare
TOKEN=$(curl -s -X POST "$API_URL/login" -H "Content-Type: application/json" \
  -d "{\"email\":\"$USERNAME\",\"password\":\"$PASSWORD\"}" | jq -r '.token')

if [[ "$TOKEN" == "null" || -z "$TOKEN" ]]; then
  echo "❌ Autentificare eșuată."
  exit 1
fi

echo "✅ Autentificat. Token primit."

# Creează folder pentru backup
mkdir -p workflows-backup

# Listează toate workflow-urile
WORKFLOWS=$(curl -s "$API_URL/workflows" -H "Authorization: Bearer $TOKEN" | jq -c '.data[]')

# Exportă fiecare workflow
echo "$WORKFLOWS" | while read -r workflow; do
  ID=$(echo "$workflow" | jq -r '.id')
  NAME=$(echo "$workflow" | jq -r '.name' | sed 's/ /_/g')

  echo "💾 Export $NAME ($ID)..."

  curl -s "$API_URL/workflows/$ID" -H "Authorization: Bearer $TOKEN" > "workflows-backup/$NAME-$ID.json"
done

echo "✅ Export complet. Verifică folderul workflows-backup/"
