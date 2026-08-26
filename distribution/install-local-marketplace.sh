#!/usr/bin/env bash
set -euo pipefail

replace_existing=false
if [ "${1:-}" = "--replace-existing" ]; then
  replace_existing=true
elif [ "$#" -gt 0 ]; then
  printf '%s\n' 'Tùy chọn hợp lệ duy nhất là --replace-existing.' >&2
  exit 2
fi

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
elif [ "$replace_existing" = true ]; then
  printf '%s\n' 'Đang thay đăng ký marketplace cũ bằng thư mục bundle mới.'
  codex plugin marketplace remove myleo198-chatgpt-work-plugins
  codex plugin marketplace add "$repository_root"
  printf '%s\n' 'Đã chuyển marketplace sang bundle cục bộ mới.'
else
  printf '%s\n' 'Không thể thêm mới marketplace. Nếu đây là bundle cập nhật, chạy lại với --replace-existing.' >&2
fi

codex plugin marketplace list || printf '%s\n' 'Không thể liệt kê marketplace; mở Codex và chạy /plugins để kiểm tra.' >&2
printf '%s\n' 'Hoàn tất. Bắt đầu một phiên Codex mới, rồi chạy /plugins để xác nhận các plugin cục bộ.'
