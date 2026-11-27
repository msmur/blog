---
title: "Travel: privacy"
date: "2026-11-27"
---

Travel is a personal trip planner for Android and Mac. Your trips, plans, travellers and documents (passports, visas, bookings and their files) are stored on your own devices.

When you turn on Google Drive sync, Travel asks only for access to its own hidden app folder in your Drive (`drive.appdata`). It can't see or change any of your other files. Travel uses that folder only to keep your trips and documents in sync between your own devices. Your Google account's email address is kept on your devices only, to show which account the sync uses.

Travel reads documents and scans barcodes on your phone with on-device text recognition. Nothing leaves the phone for this. If you turn on Read with AI and enter your own API key, Travel sends the text it read from that one document to OpenRouter, using your key, to fill in its fields. By default it uses only providers that don't keep your data. This is off until you turn it on, and it runs only when you ask.

Some features fetch public data when you use them:

- Maps load map tiles from OpenFreeMap.
- Place search sends what you type and the map's area to Google Places, using your own key, or to Photon (komoot) when no key is set. A Google Maps link you paste is opened to find its place.
- Live flight status sends a flight number and date to Flightera, using your own key.

These requests never carry your name, documents or other records.

Reminders are scheduled on your device.

Your data never goes to the developer or anyone else. Travel has no servers, analytics or ads.

You can remove Travel's access to Google at any time at [myaccount.google.com/permissions](https://myaccount.google.com/permissions), and you can delete its sync copy from Drive's settings (Manage apps → Travel → Delete hidden app data).

Contact: [msmaahirur@gmail.com](mailto:msmaahirur@gmail.com)
