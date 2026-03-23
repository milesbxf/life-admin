---
description: Authenticate with WHOOP via OAuth — required at the start of each new session
argument-hint: Optional — paste the auth code directly (e.g. /whoop-auth abc123), or run with no args to get the URL
---

Authenticate WHOOP using the OAuth flow:

**If "$ARGUMENTS" is non-empty**, treat it as the auth code and skip straight to step 2.

**Step 1 — Get auth URL** (only if no code provided):
1. Call `whoop-get-authorization-url`
2. Show the URL to the user and say: "Visit this URL to authorise WHOOP, then copy the `code` from the redirect URL (e.g. `localhost:3000/callback?code=XXXX`) and paste it here."
3. Wait for the user to provide the code.

**Step 2 — Exchange code for token:**
1. Call `whoop-exchange-code-for-token` with the code
2. Call `whoop-set-access-token` with the returned access token

**Step 3 — Confirm:**
Confirm success with: "WHOOP authenticated." Then optionally call `whoop-get-user-profile` to verify and show the user's name.
