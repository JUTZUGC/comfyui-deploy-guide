#!/usr/bin/env bash
set -euo pipefail
# ComfyUI 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.comfy.org
# 更新日期：2026-10-26
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

echo "ComfyUI 便携包只提供 Windows 版本；macOS / Linux 请用官方桌面版" ; exit 1

echo ""

echo "安装完成：进入 ComfyUI_windows_portable 运行 run_nvidia_gpu.bat；模型放到 ComfyUI/models 下对应目录"
echo "若结果异常或需要改配置，请参考官方文档：https://docs.comfy.org"
