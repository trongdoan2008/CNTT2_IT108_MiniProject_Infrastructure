# Hệ thống Quản lý Hạ tầng GreenTech

Dự án MiniProject của Kỹ sư hạ tầng (DevOps) tại Startup **GreenTech**: tổ chức dữ liệu dự án, tự động lọc log lỗi và đối soát thiết bị cho 100 trạm cảm biến IoT.

## 1. Cấu trúc thư mục

```text
greentech-system/
├── docs/       # README.md, srs-he-thong.docx
├── scripts/    # auto_report.bat (Windows), auto_report.sh (Linux/macOS)
├── data/       # log-he-thong.log, quan-ly-thiet-bi.xlsx
├── backup/     # bao-cao-su-co.txt (báo cáo sự cố)
└── .env        # cấu hình giả định (ẩn)
```

> Quy ước đặt tên: **kebab-case**, không dấu, không khoảng trắng.

## 2. Khởi tạo "căn cứ số" (Terminal)

Một dòng lệnh duy nhất tạo toàn bộ cây thư mục lồng nhau:

```bat
:: Windows (cmd)
mkdir greentech-system\docs greentech-system\scripts greentech-system\data greentech-system\backup
```

```bash
# Linux / macOS
mkdir -p greentech-system/{docs,scripts,data,backup}
```

Di chuyển bằng đường dẫn tương đối và tạo file cấu hình ẩn `.env`:

```bat
cd greentech-system
echo DB_PASSWORD=Gr33nT3ch_Demo_2026> .env
attrib +h .env
cd scripts
cd ..\data
cd ..
```

## 3. Hướng dẫn chạy script

```bat
:: Windows: chạy từ bất kỳ đâu
scripts\auto_report.bat
```

```bash
# Linux / macOS
bash scripts/auto_report.sh
```

Kết quả được **nối thêm** (`>>`) vào `backup/bao-cao-su-co.txt`. Script lọc các dòng chứa `CRITICAL`, `ERROR`, `TIMEOUT` bằng pipe (`type ... | findstr`), đọc theo luồng nên không tràn RAM với log 500MB.

## 4. Checklist kiểm tra thiết bị

- [ ] Trạm cảm biến bật nguồn, đèn trạng thái xanh
- [ ] RAM đúng dung lượng ghi trong `trang-thai-tram`
- [ ] Ổ lưu trữ (SSD/HDD) còn trống trên 20%
- [ ] Mã linh kiện không có khoảng trắng thừa (dùng `TRIM`)
- [ ] Cột `ten_thiet_bi` không còn lỗi `#N/A`
- [ ] `auto_report.bat` chạy không lỗi và có file `bao-cao-su-co.txt`
- [ ] Không có lệnh xóa nguy hiểm (`del /f /s /q`) trong script

## 5. Bảng thông số phần cứng

| Mã | Thiết bị | Đơn giá (VND, minh họa) | Loại storage |
|----|----------|------------------------:|:------------:|
| LK001 | CPU ARM Cortex-A72 1.5GHz | 1.450.000 | N/A |
| LK002 | CPU ESP32-S3 Dual-core 240MHz | 180.000 | N/A |
| LK003 | CPU NVIDIA Jetson Nano | 2.400.000 | N/A |
| LK004 | RAM LPDDR4 2GB | 320.000 | N/A |
| LK005 | RAM LPDDR4 4GB | 540.000 | N/A |
| LK006 | RAM LPDDR4 8GB | 980.000 | N/A |
| LK007 | SSD NVMe 128GB | 650.000 | SSD |
| LK008 | SSD SATA 256GB | 890.000 | SSD |
| LK009 | HDD 2.5 inch 500GB | 720.000 | HDD |
| LK010 | SSD NVMe 512GB | 1.350.000 | SSD |

## 6. Thời gian tải log theo tốc độ mạng

Mạng tính bằng **Mbps (bit)**, file tính bằng **MB (byte)** nên chia 8:

`MB/s = Mbps / 8` → `thời gian (s) = dung lượng MB / (MB/s)`

Ví dụ: log 500MB, mạng 100 Mbps → 12,5 MB/s → **40 giây**. Tính tự động trong sheet `tinh-thoi-gian-tai-log` của file Excel.

## 7. Lưu ý bảo mật

`.env` trong repo chỉ chứa **mật khẩu giả định** để nộp bài. Với dự án thật, không commit `.env` lên GitHub.
