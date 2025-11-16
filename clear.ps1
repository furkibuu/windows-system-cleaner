$ErrorActionPreference = "SilentlyContinue"
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "Bu script'in tam potansiyelini kullanmak için YÖNETİCİ olarak çalıştırılması gerekiyor." -ForegroundColor Red
    Write-Host "Temel temizlik yapılacak, ancak Windows Temp ve Geri Dönüşüm Kutusu atlanabilir." -ForegroundColor Yellow

    Start-Sleep -Seconds 5
}

Write-Host "Temizleme işlemi başlıyor..." -ForegroundColor Yellow
Write-Host "----------------------------------------------------"


$userTemp = $env:TEMP
Write-Host "Kullanıcı geçici dosyaları temizleniyor: $userTemp" -ForegroundColor Cyan
Get-ChildItem -Path $userTemp -Recurse | Remove-Item -Recurse -Force
Write-Host "Kullanıcı geçici dosyaları temizlendi." -ForegroundColor Green
Write-Host "----------------------------------------------------"


if ($isAdmin) {

    $windowsTemp = "$env:SystemRoot\Temp"
    Write-Host "Windows geçici dosyaları temizleniyor: $windowsTemp" -ForegroundColor Cyan
    Get-ChildItem -Path $windowsTemp -Recurse | Remove-Item -Recurse -Force
    Write-Host "Windows geçici dosyaları temizlendi." -ForegroundColor Green
    Write-Host "----------------------------------------------------"


    Write-Host "Geri Dönüşüm Kutusu temizleniyor..." -ForegroundColor Cyan
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Host "Geri Dönüşüm Kutusu temizlendi." -ForegroundColor Green
    Write-Host "----------------------------------------------------"

   
    Write-Host "(YENİ) Windows Update artıkları temizleniyor. Bu işlem 5-10 dakika sürebilir..." -ForegroundColor Cyan
    
 
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
    
    Write-Host "Windows Update artıkları temizlendi." -ForegroundColor Green
    Write-Host "----------------------------------------------------"

} else {
    Write-Host "Windows Temp, Geri Dönüşüm Kutusu ve Update Temizliği için script'i YÖNETİCİ olarak çalıştırın." -ForegroundColor Yellow
    Write-Host "----------------------------------------------------"
}


Write-Host "Temizleme işlemi tamamlandı!" -ForegroundColor Yellow
Write-Host "Pencere 10 saniye içinde kapanacak."


$ErrorActionPreference = "Continue"


Start-Sleep -Seconds 10