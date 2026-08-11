[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$marketplaceManifest = Join-Path $repositoryRoot '.agents/plugins/marketplace.json'

if (-not (Test-Path -LiteralPath $marketplaceManifest -PathType Leaf)) {
    throw "Không tìm thấy marketplace manifest: $marketplaceManifest. Hãy giải nén toàn bộ bundle trước khi chạy."
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue
if (-not $codexCommand) {
    throw 'Không tìm thấy Codex CLI trong PATH. Cài Codex CLI, đăng nhập, rồi chạy lại script này.'
}

try {
    & $codexCommand.Source plugin marketplace add $repositoryRoot
    if ($LASTEXITCODE -ne 0) {
        throw "Codex CLI trả về mã $LASTEXITCODE khi thêm marketplace."
    }
    Write-Host 'Đã đăng ký marketplace cục bộ.'
} catch {
    Write-Warning "Không thể thêm mới marketplace: $($_.Exception.Message)"
    Write-Host 'Nếu marketplace này đã được thêm trước đó, hãy mở một phiên Codex mới và chạy /plugins để kiểm tra.'
}

& $codexCommand.Source plugin marketplace list
if ($LASTEXITCODE -ne 0) {
    Write-Warning 'Không thể liệt kê marketplace, nhưng lệnh thêm có thể đã hoàn thành. Mở Codex và chạy /plugins để kiểm tra.'
}

Write-Host 'Hoàn tất. Bắt đầu một phiên Codex mới, rồi chạy /plugins để xác nhận các plugin cục bộ.'
