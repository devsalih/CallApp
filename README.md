# CallApp

Voice Call Application with Agora SDK - Case Study for Articula

> **[Türkçe] CallApp**
> 
> Agora SDK ile Sesli Arama Uygulaması - Articula için Örnek Çalışma

## Description

This is a voice call application that utilizes the Agora Voice Call SDK. The application allows users to initiate and receive voice calls, as well as use speech recognition to transcribe spoken conversations into text. The transcribed text is then stored in Firebase Firestore, where it can be accessed by other users in the same voice call.

> **[Türkçe] Açıklama**
> 
> Bu uygulama, Agora Voice Call SDK'sını kullanarak sesli arama ve konuşma tanıma özelliği sağlar. Konuşmalar metne dönüştürülür ve Firebase Firestore'da saklanarak, aynı sesli aramada bulunan diğer kullanıcıların erişimine olanak tanır.

## Technologies Used

> **[Türkçe] Kullanılan Teknolojiler**

- [Agora Voice Call SDK](https://www.agora.io/en/products/voice-call/)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Firebase Firestore](https://firebase.google.com/docs/firestore)
- [Speech Recognition](https://developer.apple.com/documentation/speech)
- [Text-to-Speech](https://developer.apple.com/documentation/avfoundation/speech_synthesis)
- [SnapKit](https://github.com/SnapKit/SnapKit)

## Usage

To use the application, simply sign in with your Firebase credentials and start a voice call. During the call, any spoken conversation will be transcribed into text and stored in Firebase Firestore. Other users in the same call can access the transcribed text by listening for updates to the Firestore database.

> **[Türkçe] Kullanım**
> 
> Uygulamayı kullanmak için Firebase kimlik bilgilerinizle oturum açmanız ve bir sesli arama başlatmanız yeterlidir. Arama sırasında, konuşulan her şey metne dönüştürülür ve Firebase Firestore'da saklanır. Aynı aramada bulunan diğer kullanıcılar, Firestore veritabanındaki güncellemeleri dinleyerek dönüştürülmüş metne erişebilirler.

### Screen Shots

| Login and Register Page | Home Screen | Channel View |
| :---: | :---: | :---: |
| Giriş ve Kayıt Sayfası | Ana Ekran | Kanal Görünümü |
| ![SS1](CallApp/Assets.xcassets/ss1.imageset/ss1.png) | ![SS2](CallApp/Assets.xcassets/ss2.imageset/ss2.png) | ![SS3](CallApp/Assets.xcassets/ss3.imageset/ss3.png) |

| Converting Spoken Words to Text using Speech Recognition | Text-to-Speech Output for Transcribed Speech from Other Users |
| :---: | :---: |
| Konuşulan Kelimelerin Konuşma Tanıma ile Metne Dönüştürülmesi | Diğer Kullanıcıların Metne Dönüştürülmüş Konuşmaları için Metin-ses Çıktıs |
| ![SS4](CallApp/Assets.xcassets/ss4.imageset/ss4.png) | ![SS5](CallApp/Assets.xcassets/ss5.imageset/ss5.png) |
