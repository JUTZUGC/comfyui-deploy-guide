# ComfyUI 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.comfy.org
# 更新日期：2026-10-28
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -L --fail -o ComfyUI_windows_portable_nvidia.7z https://github.com/Comfy-Org/ComfyUI/releases/download/v0.43.0/ComfyUI_windows_portable_nvidia.7z
$h = (Get-FileHash -Algorithm SHA256 ComfyUI_windows_portable_nvidia.7z).Hash.ToLower() ; if ($h -ne '4928f88e6a8407c4574d4f7d92cfeba020d782edba4a076b7d107ecc98955e50') { throw "SHA256 校验失败，文件可能不完整，请重试" }
if (Get-Command 7z.exe -ErrorAction SilentlyContinue) { 7z x -y ComfyUI_windows_portable_nvidia.7z | Out-Null ; Write-Host '已解压到 ComfyUI_windows_portable' } else { Write-Host '未找到 7-Zip，请手动解压 ComfyUI_windows_portable_nvidia.7z' }

Write-Host ''

Write-Host '安装完成：进入 ComfyUI_windows_portable 运行 run_nvidia_gpu.bat；模型放到 ComfyUI/models 下对应目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://docs.comfy.org'
