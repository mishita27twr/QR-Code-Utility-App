# QR‑Code‑App

A simple and functional **QR Code utility web app** built with **Flutter** that lets users **scan** and **generate** QR codes directly in the browser.

🔗 **Live Demo:** [![Open QR-Code App](https://img.shields.io/badge/Open-QR%20Code%20App-blue?style=for-the-badge&logo=appveyor)](https://qr-code-app-pez2.vercel.app/)

---

## 📌 Features

- **Scan QR Codes** using your device camera (web support).  
- **Generate QR Codes** for any text or URL.  
- Clean and intuitive Flutter Web interface.  

---

## 📁 Project Structure


QR‑Code‑App/
├─ qr_utility_app/ # Flutter application source
│ ├─ lib/ # Dart source code
│ ├─ web/ # Web configuration and assets
│ └─ pubspec.yaml # Flutter dependencies
├─ vercel_build.sh # Build script for Vercel deployment
└─ vercel.json # Vercel deployment configuration


---

## 🛠️ Getting Started (Development)

To run the project locally:

1. **Clone the repository:**

```bash
git clone https://github.com/mishita27twr/QR-Code-App.git
cd QR-Code-App/qr_utility_app
Install Flutter dependencies:
flutter pub get
Run in web mode:
flutter run -d chrome

The app will open in your default browser for testing.

🚀 Deployment Details

This project is deployed using Vercel:

The build script (vercel_build.sh) installs Flutter, enables web support, fetches dependencies, and builds the web release.
The Vercel configuration file (vercel.json) points the deployment to serve the static build output.

Every push to the main branch automatically triggers a new build & deploy on Vercel.

ℹ️ Requirements
Flutter SDK version >= 3.29.0
A modern browser with camera support for scanning QR codes
📦 Live Deployment

Your project is live at:

👉 https://qr-code-app‑pez2.vercel.app/

You can share this link with others to try the QR Code scanner & generator online.

📄 License

This project is open‑source and free to use.


---

If you want, I can also add **badges** (e.g., GitHub stars, Vercel deploy status, Flutter version required) at the top of the README to make it look more professional. Let me know if you want that!
::contentReference[oaicite:0]{index=0}