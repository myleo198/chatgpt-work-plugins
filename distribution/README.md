# Cài từ bundle cục bộ

Thư mục này giúp dùng cùng marketplace trên máy tính khác mà không cần Plugin Portal, gói trả phí, hoặc GitHub sau khi bạn đã giải nén bundle.

## Windows (PowerShell)

1. Giải nén toàn bộ bundle, giữ nguyên cấu trúc thư mục.
2. Mở PowerShell tại thư mục vừa giải nén.
3. Chạy:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\distribution\install-local-marketplace.ps1
   ```

`Bypass` ở đây chỉ áp dụng cho đúng tiến trình cài đặt đang chạy; script không thay đổi Execution Policy thường trực. Script đăng ký marketplace cục bộ bằng Codex CLI và kiểm tra manifest. Các plugin trong manifest được đánh dấu `INSTALLED_BY_DEFAULT`. Mở một phiên Codex mới rồi chạy `/plugins` để xác nhận hoặc quản lý trạng thái plugin.

## macOS / Linux

```bash
bash ./distribution/install-local-marketplace.sh
```

## Điều kiện

- Codex CLI phải được cài và đã đăng nhập trên máy đích.
- Không có token, `.env`, dữ liệu Aki, cache, hoặc mã nguồn ngoài bundle.
- Các workflow dùng dịch vụ bên ngoài (Firecrawl, OpenWiki provider, TencentDB, Aki server) vẫn yêu cầu bạn tự cấu hình quyền và thông tin xác thực khi thực sự dùng chúng.

## Nếu script báo lỗi

- Nếu `codex` không có trong PATH: cài Codex CLI, đăng nhập, rồi chạy lại script.
- Nếu marketplace đã tồn tại: đây không phải lỗi; mở phiên Codex mới và kiểm tra `/plugins`.
- Với OpenWiki trên Windows báo `running scripts is disabled`: mở plugin **OpenWiki Work** và dùng skill `powershell-openwiki-fix`. Skill này chỉ sửa `CurrentUser` sang `RemoteSigned` khi không có Group Policy quản lý.
