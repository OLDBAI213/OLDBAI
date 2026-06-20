# ICE 宇宙探索助手安装说明

## 推荐安装：添加卫月第三方仓库

仓库地址：

```text
https://raw.githubusercontent.com/OLDBAI213/Ices-Cosmic-Exploration-CN/Main-Branch/pluginmaster.json
```

使用方法：

1. 启动 XIVLauncherCN 并进入游戏。
2. 打开卫月设置。
3. 进入实验性功能 / 第三方插件仓库。
4. 添加上面的仓库地址并保存。
5. 打开卫月插件安装器。
6. 搜索 `宇宙探索助手` 或 `ICE`。
7. 安装并启用。

## 手动安装：用于测试包

只有在仓库刷新失败、网络访问 GitHub Release 失败，或需要测试指定 ZIP 时使用。

1. 完全退出 FF14 和 XIVLauncherCN。
2. 打开目录：

```text
%APPDATA%\XIVLauncherCN\installedPlugins
```

3. 如果里面已有 `ICE` 文件夹，先改名备份，例如 `ICE_backup`。
4. 新建目录：

```text
ICE\0.0.78.10
```

5. 把 `ICE.zip` 里面的所有文件解压到：

```text
%APPDATA%\XIVLauncherCN\installedPlugins\ICE\0.0.78.10
```

6. 重新启动 XIVLauncherCN 和游戏。
7. 打开卫月插件列表，找到 `宇宙探索助手` 并启用。

## 常见问题

### 插件不显示

- 确认第三方仓库地址没有多空格。
- 确认当前使用的是国服 XIVLauncherCN。
- 重新打开插件安装器并刷新插件列表。

### 插件加载失败

- 确认卫月是 API 15 环境。
- 确认没有同时保留多个手动安装的旧 ICE 目录。
- 先删除手动安装目录，再使用第三方仓库重新安装。

### 依赖功能不可用

ICE 会调用制作、采集、钓鱼和导航相关插件能力。不同模式可能需要 Artisan、AutoHook、vnavmesh 等依赖插件。
