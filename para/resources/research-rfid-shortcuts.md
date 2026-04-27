# RFID & iOS Hardware Bridging Research

## Objective
Enable low-friction "Life Admin" triggers using physical RFID tags and iOS Shortcuts, bridging the gap between physical actions and the Hermes agent.

## Implementation Architecture
1. **Physical Layer**: NTAG215 RFID tags placed at point-of-action (e.g., dog food bin, bedside, front door).
2. **Trigger Layer**: iOS Shortcuts "Automation" triggered by "NFC" scan. Target device: iPhone or iPad.
3. **Transport Layer**: HTTP POST request from iOS to Hermes Webhook endpoint.
4. **Action Layer**: Hermes `life-admin-capture` skill routes the payload to PARA or specific tools (e.g., `todo`).

## Specific Use-Case Ideas
- **Stock Depleted**: Tag on the dog food container → "Order more dog food" task in PARA.
- **Gym Entry**: Tag on the gym bag → Logs "Workout started" and triggers a high-protein dinner suggestion for the 5 PM audit.
- **Sleep Mode**: Tag on the bedside table → Triggers WHOOP journal pre-fill and silences non-essential notifications.

## iOS Shortcut Schema (Reference for future setup)
To be used in a "Get Contents of URL" action:
- **URL**: `https://<hermes-gateway-url>/webhooks/capture`
- **Method**: `POST`
- **Headers**: `X-API-Key: <your-key>`
- **Body (JSON)**:
```json
{
  "source": "rfid-tag-dogfood",
  "input": "Order more dog food",
  "category": "task",
  "area": "home"
}
```

## Status
- [x] Research completed.
- [ ] Implementation (Deferred until new house).
