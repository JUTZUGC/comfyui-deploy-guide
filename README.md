# ComfyUI 一键安装指南

> 第三方部署指南 · 非 ComfyUI 官方仓库。官方项目：[Comfy-Org/ComfyUI](https://github.com/Comfy-Org/ComfyUI)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://docs.comfy.org)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己找整合包，让百度搭子下载、校验、解压，放好模型就能出图。

⚠️ 本指南下载的是 Windows 便携包，需要 7-Zip 解压；NVIDIA / AMD / Intel / ARM64 四种包别下错。首次启动要自己放模型，显存不足跑不动。macOS / Linux 请用官方桌面版。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/comfyui-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按官方 Release 下载 Windows 便携包、核对 SHA256，再用 7-Zip 解压到当前目录，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## ComfyUI 是什么？

ComfyUI 是开源的节点式 AI 绘图工作流（本地推理）（协议：GPL-3.0，<img src="https://img.shields.io/github/stars/Comfy-Org/ComfyUI?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

用节点连线搭出 AI 绘图流程：加载模型、写提示词、加 ControlNet / LoRA、批量出图，全在本机跑；社区工作流可以直接导入复用。

- 节点式工作流：文生图、图生图、ControlNet、LoRA、放大、批量
- 本地推理：模型与出图都在本机
- 平台：Windows 便携包（NVIDIA / AMD / Intel / ARM64），macOS / Linux 另有桌面版
- 生态：ComfyUI Manager 等插件可扩展

（来源：[官方仓库](https://github.com/Comfy-Org/ComfyUI)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 143k stars | GPL-3.0 开源，生态最大 |
| 便携包免安装 | 解压即用，不污染系统 Python |
| 社区工作流通用 | 看到的工作流基本都能直接导入 |
| 本地推理 | 出图不上传，隐私可控 |
| 插件生态 | Manager、ControlNet、各类节点齐全 |

| 需要注意 | 说明 |
|---|---|
| 显卡要求高 | 显存小会跑不动大模型 |
| 包体很大 | 便携包 1.4–2 GB，还要另下模型 |
| 只提供 Windows 便携包 | macOS / Linux 要走桌面版或源码 |
| 需要 7-Zip | 解压 7z 格式 |
| 模型来源要自己找 | 官方不附带模型，注意来源与授权 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
echo "ComfyUI 便携包只提供 Windows 版本；macOS / Linux 请用官方桌面版" ; exit 1
```

安装包来源：[https://github.com/Comfy-Org/ComfyUI/releases/latest](https://github.com/Comfy-Org/ComfyUI/releases/latest)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v0.42.1 五个 Windows 便携包与 SHA256  digest 已核对 | 已核对 2026-10-26 |
| 未下载安装（便携包 1.4–2 GB，本机网络不适合完整拉取） | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

ComfyUI 本身不是 MCP server，但有第三方 MCP / API 封装。本仓库的 MCP 只提供下载、校验、解压与启动步骤。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\comfyui-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

1. 进入 `ComfyUI_windows_portable`，双击 `run_nvidia_gpu.bat`（AMD 用 `run_amd_gpu.bat`，Intel 用 `run_cpu.bat`）
2. 浏览器会自动打开 `http://127.0.0.1:8188`
3. 模型按类型放：`ComfyUI/models/checkpoints`、`loras`、`vae`、`controlnet`
4. 想装插件：装 ComfyUI Manager 后在界面里搜索安装

### 选哪个包

| 显卡 | 包 |
|---|---|
| NVIDIA | `ComfyUI_windows_portable_nvidia.7z` |
| 较新 NVIDIA（CUDA 12.6） | `ComfyUI_windows_portable_nvidia_cu126.7z` |
| AMD | `ComfyUI_windows_portable_amd.7z` |
| Intel 核显 / 无独显 | `ComfyUI_windows_portable_intel.7z` |
| ARM64 | `ComfyUI_windows_portable_nvidia_arm64.7z` |

## 常见坑

- 下错包：先看自己显卡，NVIDIA 选 nvidia，AMD 选 amd，Intel 选 intel，ARM64 选 arm64
- 解压失败：便携包是 7z，需装 7-Zip；Windows 自带解压不支持
- 启动报显存不足：换小模型或加 `--lowvram` 参数
- 浏览器打不开 8188：确认脚本窗口没有报错，端口没被占用
- 模型看不到：要放到 `ComfyUI/models` 下对应子目录，文件名别乱改
- 下载慢或中断：大文件建议用下载工具续传，校验不通过就重下
- 别把未知来源的工作流直接跑：部分节点会执行脚本，先看依赖再安装

## 免责声明

本仓库为第三方指南，与 ComfyUI 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://docs.comfy.org)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
