# Currency Converter App

Aplikasi Konversi Mata Uang sederhana menggunakan Flutter, yang memungkinkan pengguna untuk mengonversi satu mata uang ke mata uang lain secara real-time menggunakan FreeCurrencyAPI.

## API yang Digunakan

FreeCurrencyAPI: API ini menyediakan data nilai tukar mata uang real-time yang digunakan dalam aplikasi ini.

https://freecurrencyapi.com/

## Struktur Proyek
- `lib/main.dart`: Berisi kode utama yang memulai aplikasi Flutter.
- `lib/screen/currency_home.dart`: Berisi kode layar utama aplikasi, tempat pengguna memasukkan mata uang dan jumlah yang akan dikonversi.
- `lib/service/currency_service.dart`: Berisi logika untuk memanggil API FreeCurrencyAPI dan mengelola hasil respons API.

## Instalasi

Perlu menginstal paket http yang diperlukan untuk mengirim permintaan HTTP ke API FreeCurrencyAPI dengan menjalankan perintah berikut di terminal:
```bash
flutter pub add http
