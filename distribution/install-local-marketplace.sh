#!/usr/bin/env bash
set -euo pipefail

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
repository_root="$(CDPATH= cd -- "$script_dir/.." && pwd)"
manifest="$repository_root/.agents/plugins/marketplace.json"

if [ ! -f "$manifest" ]; then
  printf '%s\n' "Không tìm thấy marketplace manifest: $manifest. Hãy giải nén toàn bộ bundle trước khi chạy." >&2
  exit 1
fi

if ! command -v codex >/dev/null 2>&1; then
  printf '%s\n' 'Không tìm thấy Codex CLI trong PATH. Cài Codex CLI, đăng nhập, rồi chạy lại script này.' >&2
  exit 1
fi

if codex plugin marketplace add "$repository_root"; then
  printf '%s\n' 'Đã đăng ký marketplace cục bộ.'
else
  printf '%s\n' 'Không thể thêm mới marketplace (có thể đã tồn tại). Tiếp tục kiểm tra.' >&2
fi

codex plugin marketplace list || printf '%s\n' 'Không thể liệt kê marketplace; mở Codex và chạy /plugins để kiểm tra.' >&2
printf '%s\n' 'Hoàn tất. Bắt đầu một phiên Codex mới, rồi chạy /plugins để xác nhận các plugin cục bộ.'
