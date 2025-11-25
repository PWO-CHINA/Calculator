# 在 D:\qpp 安装 Git（说明）

这个说明配合 `install_git_to_d_qpp.ps1` 脚本使用，脚本位于仓库根目录。

重要事项
- 请以 管理员 身份运行 PowerShell（右键 PowerShell -> 以管理员身份运行）。
- 脚本会下载来自 Git for Windows 官方 release 的最新 64-bit 安装包并尝试使用静默参数安装到 `D:\qpp\Git`。
- 修改安装目录：运行脚本时传入 `-InstallDir` 参数，例如：`.\install_git_to_d_qpp.ps1 -InstallDir 'D:\qpp\MyGit'`。

快速运行步骤
1. 打开“以管理员身份运行”的 PowerShell。  
2. 进入脚本所在目录：  
```powershell
Set-Location 'D:\the lab for html'
```
3. （可选）允许运行脚本一次性策略：
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
```
4. 执行脚本：
```powershell
.\install_git_to_d_qpp.ps1
```

安装后
- 脚本会尝试在安装目录下找到 `cmd\git.exe` 并打印版本号。例如：`git version 2.xx.x.windows.x`。
- 若需要将 Git 路径加入系统 PATH，可在安装后手动将 `D:\qpp\Git\cmd`、`D:\qpp\Git\mingw64\bin`、`D:\qpp\Git\usr\bin` 添加到系统环境变量 `Path`（需要管理员权限）。

安全性
- 脚本使用官方 Git for Windows 的 `releases/latest/download/Git-64-bit.exe` 链接进行下载，若你希望校验完整性，请在下载后运行：
```powershell
Get-FileHash .\Git-64-bit.exe -Algorithm SHA256
```
并与 Git for Windows release 页面上的校验值对比（可手动打开 release 页面）。

如需我把这份脚本调整为非静默安装或更改其它安装选项，请告诉我具体要求。