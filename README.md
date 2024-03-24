<div align="center">


<img src="https://raw.githubusercontent.com/xrgzs/xrsys-api/main/api.ico" alt="xrapi" width="20%" />

# 潇然系统部署接口

</div>

潇然系统部署接口（XRSYSAPI，`api.exe`）完成[潇然系统部署](https://sys.xrgzs.top)的整个流程对各种组件的调用工作，包括但不限于调用万能驱动安装、用户名创建等🌟🚀

📄[文档](https://sys.xrgzs.top/diy/api/)

🔗[下载地址](https://url.xrgzs.top/xrsysapi)

**⛔警告：该组件不支持单独使用，需要搭配 `osc.exe`**，更多信息请阅读文档

> 🌄图标来自：https://icons8.com/icons/fluency

---

以下内容可能已经过期，建议前往文档查看

潇然系统部署接口接管了整个系统部署流程，为整个系统部署流程提供了完整的框架

具体执行参数如下：

- 部署前 - `api.exe /1`
- 部署中 - `api.exe /2`
- 部署后 - `api.exe /3`
- 登录时 - `api.exe /4`
- 进桌面 - `api.exe /5`

潇然系统部署接口只能在未部署的系统镜像（即执行过sysprep的系统）中，才能被系统安装组件完整调用，如果系统已经完成部署，则无法使用此部署插件

且潇然系统部署接口只能存放到指定目录中运行：`C:\Windows\Setup\Set\api.exe`

因此，为了实现通用化，我们将系统优化大多数都集成在潇然系统优化组件（XRSYSOSC，`osc.exe`）中

同时，潇然系统部署接口依赖于潇然系统优化组件提供的`apifiles`

> `api.exe` 需要调用到 `osc.exe` 内的相关文件，会创建 `Set\needoscapifiles.txt` 并运行 `osc.exe` 让其提供 `apifiles`

潇然系统部署接口支持使用第三方封装工具辅助调用，只需在对应时机正确设置好执行参数并调用即可

