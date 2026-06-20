# v0.0.78.7000 发布说明

## 主要内容

- `pluginmaster.json` 从 ICE 单插件清单扩展为 OLDBAI FF14 国服插件合集。
- 新增中文仓库条目和 Release 包：
  - `生产制作助手` / Artisan `4.0.5.15`
  - `自动钓鱼` / AutoHook `6.0.0.46`
  - `采集与钓鱼资料库` / GatherBuddyReborn `7.5.0.2`
  - `导航寻路基础` / vnavmesh `0.6.5.0`
- 保留 `宇宙探索助手` / ICE `0.0.78.7000`。
- 插件仓库列表中的名称、简介、说明和标签改为中文，方便在插件安装器里搜索和识别。
- 新增可重复执行的本地打包脚本：`scripts/package-oldbai-plugins.ps1`。

## 仓库地址

```text
https://raw.githubusercontent.com/OLDBAI213/OLDBAI/Main-Branch/pluginmaster.json
```

## Release 下载文件

| 文件 | 版本 | SHA256 |
|---|---|---|
| ICE.zip | 0.0.78.7000 | ddd3d06c2c856187d1746dd378f18c047c5dccb4537d77dd5f56625de9c74a71 |
| Artisan.zip | 4.0.5.15 | b46887f72abe3016b9e5ddabe3028e86e369f57b71266902f004f22443b9e367 |
| AutoHook.zip | 6.0.0.46 | 290a52289211c795a3d32648abbb9bf01e95c1dfef72ddf709960efe7642d561 |
| GatherBuddyReborn.zip | 7.5.0.2 | eaef27636e0b2e1eda7a82ece8fcad8f8ed83cac80bb2c5b2121dcb1d74fa611 |
| vnavmesh.zip | 0.6.5.0 | 272781eaff86651c7c33638191c5a38bb357781530f8bff5f1f1a7ff4d3db193 |

## 注意事项

- 本版本面向国服 XIVLauncherCN / 卫月 API 15。
- 插件包不包含用户个人配置、角色数据、截图或本机路径。
- 自动化类插件请先理解设置含义，再按自己的需求启用。
- 本仓库保留上游作者署名；核心能力来自对应上游项目，本仓库负责中文整理、国服适配和组合分发。
