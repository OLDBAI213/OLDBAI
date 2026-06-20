# OLDBAI FF14 国服插件合集

Dalamud 自定义插件仓库地址：

```text
https://raw.githubusercontent.com/OLDBAI213/OLDBAI/Main-Branch/pluginmaster.json
```

这是面向国服 XIVLauncherCN / 卫月 API 15 的中文插件合集。当前目标不是声明原创插件，而是把生产、采集、钓鱼、导航和宇宙探索相关插件整理成一个朋友能直接安装、能看懂名称和说明的仓库。

## 当前收录

| 中文名 | 插件名 | 主要用途 |
|---|---|---|
| 宇宙探索助手 | ICE | 宇宙探索任务、制作、采集和模式辅助 |
| 生产制作助手 | Artisan | 制作队列、制作模拟、宏、自动制作和制作诊断信息来源 |
| 自动钓鱼 | AutoHook | 自动抬杆、钓鱼流程辅助，保留内置中文资源 |
| 采集与钓鱼资料库 | GatherBuddyReborn | 采集点、鱼类、天气、时限点、闹钟和路线资料 |
| 导航寻路基础 | vnavmesh | 本地导航网格、路径计算和后续自动行动基础 |

## 安装方式

1. 启动国服 XIVLauncherCN 并进入游戏。
2. 打开卫月设置。
3. 进入“实验性功能 / 第三方插件仓库”。
4. 添加仓库地址：

   ```text
   https://raw.githubusercontent.com/OLDBAI213/OLDBAI/Main-Branch/pluginmaster.json
   ```

5. 保存后打开插件安装器。
6. 搜索中文名安装，例如：

   ```text
   宇宙探索助手
   生产制作助手
   自动钓鱼
   采集与钓鱼资料库
   导航寻路基础
   ```

要求：

- 国服 XIVLauncherCN / 卫月
- Dalamud API 15
- GitHub Release 下载可访问

如果第三方仓库暂时无法刷新，可以下载 Release 里的对应 zip，参考 [安装说明](docs/install.md)。

## 组合关系

- 做生产：优先安装 `生产制作助手`。
- 做采集和钓鱼资料查询：安装 `采集与钓鱼资料库`。
- 做钓鱼自动抬杆：安装 `自动钓鱼`。
- 需要自动路线、路径计算或以后让 AI 调用移动能力：安装 `导航寻路基础`。
- 做宇宙探索：安装 `宇宙探索助手`，再按模式补齐制作、采集、钓鱼、导航相关插件。

## 来源和署名

本仓库用于中文整理、国服环境适配和插件仓库分发。插件核心能力来自对应上游项目，署名保留在插件清单和文档中。

| 插件 | 上游/来源 | 许可证信息 |
|---|---|---|
| ICE | https://github.com/LeontopodiumNivale14/Ices-Cosmic-Exploration | 见上游与本仓库 LICENSE |
| Artisan | https://github.com/PunishXIV/Artisan | BSD-3-Clause |
| AutoHook | https://github.com/PunishXIV/AutoHook | BSD-3-Clause |
| GatherBuddyReborn | https://github.com/FFXIV-CombatReborn/GatherBuddyReborn | Apache-2.0 |
| vnavmesh | https://github.com/AtmoOmen/ffxiv_navmesh-cn | 未在 GitHub 元数据中识别到许可证，保留来源署名 |

本分支不声明原创上游逻辑；中文维护、国服适配、插件清单和发布流程由本仓库继续整理。
