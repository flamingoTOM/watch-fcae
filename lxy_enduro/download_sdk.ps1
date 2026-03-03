# Connect IQ SDK 下载和安装脚本

Write-Host "正在准备下载 Garmin Connect IQ SDK..." -ForegroundColor Green

$sdkVersion = "7.4.1-2025-01-07-dcc1e6836"
$sdkUrl = "https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-win-$sdkVersion.zip"
$sdkDir = "$env:APPDATA\Garmin\ConnectIQ\Sdks"
$downloadPath = "$env:TEMP\connectiq-sdk.zip"

# 创建目录
New-Item -ItemType Directory -Force -Path $sdkDir | Out-Null

Write-Host "下载 SDK (这可能需要几分钟)..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $sdkUrl -OutFile $downloadPath -UseBasicParsing
    Write-Host "SDK 下载完成！" -ForegroundColor Green
    
    Write-Host "正在解压 SDK..." -ForegroundColor Yellow
    Expand-Archive -Path $downloadPath -DestinationPath $sdkDir -Force
    
    Write-Host "SDK 安装完成！" -ForegroundColor Green
    Write-Host "SDK 位置: $sdkDir" -ForegroundColor Cyan
    
    # 清理
    Remove-Item $downloadPath -Force
} catch {
    Write-Host "下载失败: $_" -ForegroundColor Red
    Write-Host "请手动下载 SDK：https://developer.garmin.com/connect-iq/sdk/" -ForegroundColor Yellow
}
