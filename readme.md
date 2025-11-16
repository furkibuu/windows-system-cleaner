# Windows Gelişmiş Temizleme Script'i

Windows sisteminizi gereksiz ve yer kaplayan artık dosyalardan temizlemek için tasarlanmış basit ama güçlü bir PowerShell script'i.

## 🚀 Ne Yapar?

Bu script, sistemi yavaşlatan ve disk alanı tüketen yaygın "çöp" dosyaları hedefler. Tam bir temizlik için yönetici olarak çalıştırılması gerekir.

Script'in temizlediği başlıca alanlar:
* **Kullanıcı Geçici Dosyaları:** `%TEMP%` klasöründeki tüm geçici dosyalar.
* **Windows Geçici Dosyaları:** `C:\Windows\Temp` klasöründeki sistem geçici dosyaları.
* **Geri Dönüşüm Kutusu:** Tüm sürücülerdeki Geri Dönüşüm Kutusu'nu boşaltır.
* **Windows Update Artıkları:** `DISM` komutunu kullanarak eski ve gereksiz Windows Update bileşenlerini temizler (`WinSxS` klasörünü optimize eder). **Bu adım en çok yer açan adımdır.**

## 📂 Proje Dosyaları

Bu proje iki ana dosyadan oluşur:

1.  **`clear.ps1`**:
    * Tüm temizlik mantığını içeren ana PowerShell script'idir.
    * Çalıştığında hangi adımı attığını konsola yazar.
    * İşlem bitince 10 saniye bekleyip kapanır.

2.  **`ready.bat`**:
    * PowerShell script'ini çalıştırmak için kullanılan yardımcı bir "başlatıcı" dosyasıdır.
    * Gerekli olan `ExecutionPolicy` ayarını (`-ExecutionPolicy Bypass` ile) sadece o anlık atlayarak script'in sorunsuz çalışmasını sağlar.
    * **Temizlik yapmak için kullanmanız gereken dosya budur.**

## 🛠️ Nasıl Kullanılır?

Script'i çalıştırmak çok basittir:

1.  `clear.ps1` ve `ready.bat` dosyalarının **ikisinin de aynı klasörde** olduğundan emin olun.
2.  `ready.bat` dosyasına **sağ tıklayın**.
3.  **"Yönetici olarak çalıştır"** seçeneğine tıklayın.
4.  Açılan siyah komut istemi penceresi sizden izin isteyebilir (UAC), **"Evet"** deyin.
5.  Script çalışacak ve yaptığı işlemleri size gösterecektir.

> **ÖNEMLİ NOT:** Windows Update artıklarını temizleme (`DISM`) adımı, bilgisayarınızın durumuna göre 5 ila 10 dakika sürebilir. Lütfen işlem bitene kadar pencereyi kapatmayın.

## ⚠️ Uyarı

Bu script, sisteminizden dosya silmek üzerine tasarlanmıştır. `TEMP` klasörlerini ve Geri Dönüşüm Kutusu'nu temizler. Normal şartlarda bu işlemler tamamen güvenli olsa da, script'i kullanmanın sorumluluğu tamamen size aittir.