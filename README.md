
# ChatGPT #
Aplikasi ini adalah aplikasi obrolan yang menggunakan kecerdasan buatan untuk memproses dan merespons pesan yang dikirimkan oleh pengguna. Aplikasi ini dibangun dengan menggunakan Flutter dan API ChatGPT yang disediakan oleh OpenAI. Aplikasi ini menyediakan banyak pilihan model AI yang bisa digunakan.

# Cara Install atau Build Aplikasi #

## Prasyarat ##
Sebelum memulai instalasi atau build aplikasi, pastikan bahwa komputer Anda sudah terinstal Flutter. Jika belum terinstal, silakan kunjungi situs web Flutter untuk petunjuk instalasi.

## Langkah-langkah ##
1. Clone repositori ini ke komputer Anda.
2. Buka terminal dan arahkan ke direktori aplikasi.
3. Jalankan perintah flutter pub get untuk menginstal semua paket dan dependensi yang dibutuhkan.
4. Buka file *`lib/constants/api_consts.dart`* dan ubah nilai konstanta API_KEY dengan API key Anda.
5. Hubungkan perangkat Android atau iOS ke komputer Anda atau gunakan emulator yang telah diinstal.
6. Jalankan perintah `flutter run` untuk menjalankan aplikasi di perangkat atau emulator.

## Cara Build Aplikasi ke File APK ##
1. Ikuti langkah-langkah di atas untuk menginstal aplikasi.
2. Jalankan perintah `flutter build apk` untuk membuat file APK dari aplikasi.
3. File APK akan tersimpan di direktori ***`build/app/outputs/flutter-apk/app-release.apk`***.
4. File APK tersebut bisa diinstal ke perangkat Android. 

# Cara Mengubah API Key #
Untuk mengubah API key pada aplikasi ChatGPT, silakan ikuti langkah-langkah berikut:

1. Buka file ***`lib/constants/api_consts.dart`***.
2. Ubah nilai konstanta API_KEY dengan API key Anda.
3. Simpan perubahan yang dilakukan.
4. Build atau jalankan aplikasi untuk menerapkan perubahan tersebut.
5. Pastikan untuk tidak membagikan API key Anda kepada orang lain untuk menjaga keamanan dan privasi aplikasi Anda.