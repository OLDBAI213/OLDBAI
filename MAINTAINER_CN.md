# OLDBAI 国服插件合集维护说明（CN-MAINTAINER v3）

## 文档目的

- 作为 OLDBAI 国服插件合集的维护文档。
- `README.md` 面向用户；维护规则只写在本文件。

## 维护原则

- 分发以你的仓库为准：
  - 源码：`OLDBAI213/OLDBAI`
  - 仓库清单：`https://raw.githubusercontent.com/OLDBAI213/OLDBAI/Main-Branch/pluginmaster.json`
- 版本号必须可比较、可追溯、可复现。
- Codex 可以参与上游同步、冲突处理、中文文本补全、构建验证、插件包整理和发布流程配置；涉及功能逻辑时优先保留上游实现。
- 公开分发必须保留上游作者、来源和许可证说明。
- 不把用户个人配置、截图、角色数据、账号资料、`pluginConfigs` 或 `dalamudConfig` 放进仓库或 Release 包。

## 上游同步规则（避免历史再次混乱）

- 同步顺序固定为：**先同步上游，再做本地化修复**。
- 仅使用 `merge` 同步上游，不使用 `cherry-pick` 复制上游提交。
- 不使用 GitHub 网页端的“丢弃 N 个提交”同步方式。

标准流程：

1. `git fetch upstream --prune`
2. `git checkout Main-Branch`
3. `git merge upstream/Main-Branch`
4. 处理冲突并编译验证
5. 再进行本地化/CN 适配修复并提交

## ICE 版本规则

- 版本真源：`ICE/ICE.csproj`
- 发版时必须保持：
  - `Version == AssemblyVersion == FileVersion`
- 版本格式：4 段纯数字 `A.B.C.D`
- 推荐第 4 段使用 `UUFF`：
  - `UU`：上游第 4 段（两位）
  - `FF`：本地修订号（`00-99`）

示例：

- 上游：`0.0.76.11`
- 纯上游同步：`0.0.76.1100`
- 本地修订：`0.0.76.1101`、`0.0.76.1102`
- 上游升级：`0.0.76.1200`

递增规则：

1. 上游不变：`FF + 1`
2. 上游升级：`UU` 更新，`FF` 重置为 `00`
3. 已发布版本必须严格递增，禁止回退

## 插件合集打包规则

ICE 以源码构建为准。其他收录插件目前按国服可运行安装目录重新打包，发布前必须确认 manifest 中文字段、版本号、下载链接和上游署名。

打包脚本：

```powershell
& .\scripts\package-oldbai-plugins.ps1 -ReleaseTag v0.0.78.7000
```

脚本输出：

- `E:\AI\ff14-investigation\artifacts\oldbai-plugin-bundle-<时间>\packages\*.zip`
- `E:\AI\ff14-investigation\artifacts\oldbai-plugin-bundle-<时间>\package-report.json`

当前收录插件：

| 中文名 | InternalName | 版本来源 |
|---|---|---|
| 宇宙探索助手 | ICE | 本仓库源码构建 |
| 生产制作助手 | Artisan | 本机已安装/中文整理运行包 |
| 自动钓鱼 | AutoHook | 本机已安装运行包，含 `zh` 资源 |
| 采集与钓鱼资料库 | GatherBuddyReborn | 本机已安装运行包 |
| 导航寻路基础 | vnavmesh | 本机已安装运行包 |

## 发版流程

1. **确定版本号**
   - ICE 按本文件“ICE 版本规则”生成新版本。
   - 其他插件保持上游/已安装插件版本，不伪造版本号。
2. **更新版本真源**
   - 修改 `ICE/ICE.csproj` 中 `Version`。
   - 修改 `ICE/ICE.json` 中 `RepoUrl` 指向 `OLDBAI213/OLDBAI`。
3. **本地构建**
   - `dotnet build ICE/ICE.csproj -c Release -v minimal`
4. **打包合集插件**
   - 运行 `scripts/package-oldbai-plugins.ps1`。
   - 检查 `package-report.json` 中版本、大小和 SHA256。
5. **发布源码仓库 Release**
   - 创建 tag：`v<版本号>`
   - 上传发布资产（`ICE.zip`、`Artisan.zip`、`AutoHook.zip`、`GatherBuddyReborn.zip`、`vnavmesh.zip`）
6. **更新 pluginmaster**
   - 修改根目录 `pluginmaster.json` 中各条目：
     - `AssemblyVersion`
     - `DownloadLinkInstall`
     - `DownloadLinkUpdate`
     - `RepoUrl`
     - 中文 `Name`、`Punchline`、`Description`
7. **分发校验**
   - 确认 `pluginmaster` 链接可访问
   - 确认每个 Release 资产可下载
   - 下载 zip 并检查 manifest 中文字段
8. **客户端验证**
   - Dalamud 手动检查更新并验证可安装/可加载

## 发布检查清单

- [ ] 版本号符合 4 段规则且单调递增
- [ ] `ICE/ICE.csproj` 中 `Version` 已更新
- [ ] `ICE/ICE.json` 中 `RepoUrl` 指向国服维护仓库
- [ ] `dotnet build ICE/ICE.csproj -c Release -v minimal` 通过
- [ ] Release 资产可下载
- [ ] `pluginmaster` 中版本与下载链接已更新
- [ ] 插件安装器中名称和说明显示中文
- [ ] Dalamud 客户端手动检查更新通过

## 常见问题

- **源码版本和仓库版本不一致**
  - 以 `csproj` 为准，重新发布并同步 `pluginmaster`。
- **发版后客户端不更新**
  - 检查 `AssemblyVersion` 是否递增。
  - 检查 `DownloadLinkInstall/Update` 是否指向本次发布资产。
