@echo off
setlocal EnableExtensions
rem ============================================================
rem  auto_report.bat - Robot loc log GreenTech
rem  Chay tu bat ky dau: script tu nhay ve thu muc goc du an.
rem ------------------------------------------------------------
rem  AUDIT (tham dinh an toan):
rem   [x] Script KHONG chua lenh xoa. Da loai bo kieu "del /f /s /q"
rem       do AI goi y (xoa de quy, khong hoi, rat nguy hiem).
rem   [x] Chi DOC data\log-he-thong.log, chi GHI NOI (>>) vao
rem       backup\bao-cao-su-co.txt, khong ghi de (>) du lieu cu.
rem   [x] findstr doc theo luong (stream), khong nap ca file 500MB
rem       vao RAM.
rem ============================================================

cd /d "%~dp0.."
set "LOG=data\log-he-thong.log"
set "OUT=backup\bao-cao-su-co.txt"

if not exist "%LOG%" goto :nolog
if not exist "backup" mkdir "backup"

echo ============================================== >> "%OUT%"
echo   BAO CAO SU CO HE THONG - GREENTECH >> "%OUT%"
echo   Thoi diem tao bao cao: %date% %time% >> "%OUT%"
echo   Nguon: %LOG% >> "%OUT%"
echo ============================================== >> "%OUT%"

type "%LOG%" | findstr /C:"CRITICAL" /C:"ERROR" /C:"TIMEOUT" >> "%OUT%"

set "CNT=0"
for /f %%n in ('findstr /C:"CRITICAL" /C:"ERROR" /C:"TIMEOUT" "%LOG%" ^| find /c /v ""') do set "CNT=%%n"

echo ---------------------------------------------- >> "%OUT%"
echo   Tong so dong loi nghiem trong: %CNT% >> "%OUT%"
echo ---------------------------------------------- >> "%OUT%"
echo. >> "%OUT%"

echo [OK] Da ghi bao cao vao %OUT% (%CNT% dong loi).
exit /b 0

:nolog
echo [LOI] Khong tim thay %LOG%
exit /b 1
