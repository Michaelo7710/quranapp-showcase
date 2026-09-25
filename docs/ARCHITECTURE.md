# 🏛️ QuranApp Architecture Deep-Dive & Clean Architecture Blueprint

> **Enterprise Standard:** Feature-First Clean Architecture, Reactive BLoC State Management, Drift SQLite Offline-First, and GPU-Accelerated Sacred Typography.

---

## 📐 1. Visual Arsitektur Sistem (The 3-Layer Boundary)

```mermaid
flowchart TD
    subgraph PresentationLayer["🎨 Lapisan Presentasi (UI & BLoC)"]
        UI["Flutter Widgets (Atomic UI / SDUI)"]
        Bloc["BLoC / Cubit (Deterministic State Machine)"]
        RichTextEngine["Sacred RichText & TextSpan Tajweed Engine (60 FPS)"]
        ThemeSystem["Adaptive Theme Tokens (Light, Warm Sepia, OLED Dark)"]
        UI --> Bloc
        UI --> RichTextEngine
        UI --> ThemeSystem
    end

    subgraph DomainLayer["🧠 Lapisan Domain (Logika Bisnis Murni)"]
        Entities["Domain Entities (SurahEntity, AyahEntity)"]
        UseCases["UseCases (GetSurahList, GetSurahDetail, SaveBookmark)"]
        RepoContract["QuranRepository Interface (Either<Failure, T>)"]
        Bloc --> UseCases
        UseCases --> RepoContract
        UseCases --> Entities
    end

    subgraph DataLayer["💾 Lapisan Data (Offline-First SSOT)"]
        RepoImpl["QuranRepositoryImpl (Defensive fpdart)"]
        LocalDataSource["QuranLocalDataSource (Drift SQLite DAO)"]
        PreSeededDB["Pre-Seeded SQLite (114 Surahs, 6,236 Ayahs)"]
        RepoContract -.-> RepoImpl
        RepoImpl --> LocalDataSource
        LocalDataSource --> PreSeededDB
    end

    subgraph HardwareLayer["📱 Sensor & Sistem Native"]
        Magnetometer["Magnetometer & Accelerometer (Sensor Fusion Low-Pass)"]
        AdhanMath["Astronomical Prayer Times Math (100% Offline)"]
        Wakelock["WakelockPlus (Anti-Screen Sleep saat Tilawah)"]
    end

    PresentationLayer -.-> HardwareLayer
```

---

## 🛡️ 2. Aturan Batas Arsitektural (*Architectural Invariants*)

1. **Ketergantungan Satu Arah (*The Dependency Rule*):**
   - Lapisan Domain murni bebas dari ketergantungan Flutter framework atau library pihak ketiga (`flutter/material.dart`, SQLite, network).
   - Lapisan Presentasi dan Data bergantung ke Domain, bukan sebaliknya.
2. **Penanganan Kesalahan Fungsional (*Defensive fpdart*):**
   - Dilarang melempar *unhandled exception*. Seluruh repositori mengembalikan `Future<Either<Failure, T>>`.
3. **Kedaulatan Data Lokal (*Offline-First SSOT*):**
   - Drift SQLite adalah *Single Source of Truth*. Aplikasi tidak pernah menampilkan spinner kosong saat offline.
4. **Rendering GPU Murni Bebas WebView:**
   - Ayat Al-Qur'an dan anotasi tajwid dirender langsung via `RichText` & `TextSpan` native untuk menjaga stabilitas 60–120 FPS tanpa lag memori.

---

## 🗄️ 3. Skema Basis Data Drift SQLite

```mermaid
erDiagram
    SURAHS ||--o{ AYAHS : "has many"
    SURAHS {
        int id PK "1 - 114"
        text nameArabic "Lafaz Arab Utsmani"
        text nameLatin "Transliterasi Latin"
        text translationId "Arti Nama Surah (Kemenag)"
        int numberOfAyahs "Jumlah Ayat"
        text revelationType "Makkiyah / Madaniyah"
    }
    AYAHS {
        int id PK "Auto Increment"
        int surahId FK "References SURAHS(id)"
        int ayahNumber "Nomor Ayat"
        text textUthmani "Teks Utsmani Rasm Kemenag"
        text textTajweed "Markup Anotasi Tajwid"
        text textTranslation "Terjemahan Resmi Kemenag"
        int pageNumber "Nomor Halaman Mushaf Standar"
        int juzNumber "Nomor Juz 1 - 30"
    }
    BOOKMARKS {
        int id PK "Auto Increment"
        int surahId "Surah Terakhir Dibaca"
        int ayahNumber "Ayat Terakhir Dibaca"
        text surahNameLatin "Nama Surah"
        datetime createdAt "Timestamp Penanda"
    }
```
