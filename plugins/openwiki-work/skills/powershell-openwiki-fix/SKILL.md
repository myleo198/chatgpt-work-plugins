---
name: powershell-openwiki-fix
description: Diagnose and repair Windows PowerShell errors that block local .ps1 launchers, especially OpenWiki or npm shims reporting that script execution is disabled. Use when openwiki does not start, openwiki.ps1 or npm.ps1 cannot be loaded, or a Codex/ChatGPT PowerShell launcher is blocked.
---

# Sửa PowerShell và OpenWiki

## Mục tiêu

Khôi phục việc chạy các launcher `.ps1` cục bộ, đặc biệt là `openwiki.ps1`, mà không hạ bảo mật toàn hệ thống, không lộ token và không tự chạy cập nhật wiki.

## Nguyên tắc an toàn

- Thu thập policy và đường dẫn launcher trước khi sửa.
- Chỉ dùng `RemoteSigned` ở phạm vi `CurrentUser` khi không có Group Policy bắt buộc.
- Không dùng `Bypass` hoặc `Unrestricted` làm cấu hình thường trực.
- Không chạy `Unblock-File` hàng loạt; chỉ bỏ chặn một file đã biết nguồn gốc nếu file đó có `Zone.Identifier`.
- Không in nội dung `.openwiki\\.env`, API key, access token, refresh token hoặc giá trị biến môi trường bí mật.
- Không chạy `openwiki --update` trong bước chẩn đoán; lệnh này có thể ghi lại tài liệu và gọi provider AI.

## 1. Thu thập bằng chứng

Chạy từ PowerShell:

```powershell
Get-ExecutionPolicy
Get-ExecutionPolicy -List
Get-Command openwiki -ErrorAction SilentlyContinue | Format-List Name,CommandType,Source,Path,Definition
Get-Command npm -ErrorAction SilentlyContinue | Format-List Name,CommandType,Source,Path,Definition
```

Phân loại kết quả:

- Lỗi `PSSecurityException` hoặc `running scripts is disabled` cùng policy hiệu lực `Restricted`: launcher bị chặn bởi Execution Policy.
- `MachinePolicy` hoặc `UserPolicy` có giá trị khác `Undefined`: policy do tổ chức quản lý; không cố ghi đè. Báo phạm vi policy đó cho người dùng hoặc quản trị viên.
- `CurrentUser` và `LocalMachine` đều `Undefined`, nhưng policy hiệu lực là `Restricted`: đây là mặc định Windows và có thể sửa ở `CurrentUser`.
- `openwiki` không tồn tại: kiểm tra Node/npm trước, rồi cài hoặc sửa cài đặt OpenWiki; không kết luận đây là lỗi policy.

## 2. Xác minh launcher và dấu Internet

Lấy đúng file launcher, không đoán đường dẫn:

```powershell
$openwikiCommand = Get-Command openwiki -CommandType ExternalScript -ErrorAction Stop
$openwikiPs1 = $openwikiCommand.Source
$openwikiPs1
Get-Item -LiteralPath $openwikiPs1 -Stream * | Select-Object Stream,Length
Get-AuthenticodeSignature -LiteralPath $openwikiPs1 | Select-Object Status,StatusMessage
```

`openwiki.ps1` do npm tạo thường không ký số. Với `RemoteSigned`, file cục bộ không có `Zone.Identifier` vẫn chạy được. Nếu `Zone.Identifier` có mặt, chỉ xác minh nguồn file rồi bỏ chặn chính xác file đó:

```powershell
Unblock-File -LiteralPath $openwikiPs1
```

## 3. Sửa lỗi policy cục bộ

Chỉ khi `MachinePolicy` và `UserPolicy` đều là `Undefined`, đặt policy cho tài khoản hiện tại:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
Get-ExecutionPolicy -List
```

Kết quả cần có:

```text
CurrentUser    RemoteSigned
```

Không thay đổi `LocalMachine`. Không cần quyền Administrator.

## 4. Kiểm tra sau sửa

Đầu tiên xác nhận shim npm cũng không còn bị chặn:

```powershell
npm --version
```

Sau đó chạy kiểm tra OpenWiki chỉ đọc. Dùng tiến trình con vì launcher npm `.ps1` có thể gọi `exit`:

```powershell
$openwikiPs1 = (Get-Command openwiki -CommandType ExternalScript -ErrorAction Stop).Source
$psi = [System.Diagnostics.ProcessStartInfo]::new()
$psi.FileName = (Get-Command powershell.exe).Source
$psi.Arguments = '-NoProfile -File "' + $openwikiPs1 + '" --help'
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true

$process = [System.Diagnostics.Process]::new()
$process.StartInfo = $psi
[void] $process.Start()
if (-not $process.WaitForExit(20000)) {
    $process.Kill()
    throw 'OpenWiki did not exit within 20 seconds.'
}

$stdout = $process.StandardOutput.ReadToEnd()
$stderr = $process.StandardError.ReadToEnd()
"exit=$($process.ExitCode)"
$stdout
if ($stderr) { $stderr }
```

Thành công khi mã thoát là `0` và OpenWiki in phần trợ giúp. Bước này không khởi động OAuth, không sửa connector và không ghi wiki.

## 5. Chạy OpenWiki sau khi đã xác minh

Từ thư mục gốc repository, chạy một trong các lệnh sau khi người dùng chủ động muốn tạo/cập nhật tài liệu:

```powershell
openwiki --update --print
```

```powershell
openwiki --init --print
```

Trước khi chạy, chỉ xác nhận sự tồn tại của cấu hình, không hiển thị bí mật:

```powershell
$openwikiEnv = Join-Path $env:USERPROFILE '.openwiki\\.env'
Test-Path -LiteralPath $openwikiEnv
```

Nếu OpenWiki thiếu provider hoặc thông tin xác thực, để CLI hiển thị hướng dẫn cấu hình. Không tự ghi token vào source, log hoặc GitHub Actions variables; dùng secrets cho workflow.

## 6. Báo cáo và log an toàn

Ghi nhận các dữ kiện sau trong log xử lý: policy trước/sau, phạm vi bị quản lý (nếu có), đường dẫn launcher, có/không `Zone.Identifier`, phiên bản npm, mã thoát và stdout/stderr đã lọc bí mật. Không ghi `.env` hay giá trị token.

Khi policy do Group Policy quản lý hoặc launcher không tồn tại, dừng sửa policy và báo đúng nguyên nhân thay vì dùng `ExecutionPolicy Bypass` để che lỗi.
