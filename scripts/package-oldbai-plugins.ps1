param(
    [string]$ReleaseTag = "v0.0.78.7000",
    [string]$OutputRoot = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($OutputRoot)) {
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $OutputRoot = "E:\AI\ff14-investigation\artifacts\oldbai-plugin-bundle-$stamp"
}

$installedRoot = Join-Path ([Environment]::GetFolderPath("ApplicationData")) "XIVLauncherCN\installedPlugins"
$repoUrl = "https://github.com/OLDBAI213/OLDBAI"
$downloadBase = "$repoUrl/releases/download/$ReleaseTag"

$plugins = @(
    @{
        SourceName = "Artisan"
        Version = "4.0.5.15"
        Manifest = "Artisan.json"
        Asset = "Artisan.zip"
        Author = "Taurenkey (Puni.sh), Codex(中文整理)"
        Name = "生产制作助手"
        Punchline = "一体化生产制作插件。"
        Description = "生产制作、制作队列、模拟、宏和自动制作辅助。适合作为制作信息、缺料判断和制作诊断来源。"
        Tags = @("Crafting", "Production")
        CategoryTags = @("Jobs", "Utility")
        RepoUrl = "https://github.com/PunishXIV/Artisan"
        IconUrl = "https://s3.puni.sh/media/plugin/6/icon-3h8wd5b9qr.png"
    },
    @{
        SourceName = "AutoHook"
        Version = "6.0.0.46"
        Manifest = "AutoHook.json"
        Asset = "AutoHook.zip"
        Author = "Det, Codex(中文整理)"
        Name = "自动钓鱼"
        Punchline = "自动抬杆与钓鱼流程辅助。"
        Description = "根据钓鱼条件自动抬杆，可配合采集资料库和宇宙探索使用。已保留插件内置中文资源。"
        Tags = @("Gathering", "Fishing")
        CategoryTags = @("Jobs", "Utility")
        RepoUrl = "https://github.com/PunishXIV/AutoHook"
        IconUrl = "https://s3.puni.sh/media/plugin/47/icon-k1slevjorpo.png"
    },
    @{
        SourceName = "GatherbuddyReborn"
        Version = "7.5.0.2"
        Manifest = "GatherbuddyReborn.json"
        Asset = "GatherBuddyReborn.zip"
        Author = "The Combat Reborn Team, Codex(中文整理)"
        Name = "采集与钓鱼资料库"
        Punchline = "采集、钓鱼、时限点和路线资料。"
        Description = "提供采集点、鱼类、天气、闹钟、路线和资料查询能力，适合作为采集/钓鱼信息来源。"
        Tags = @("Gathering", "Fishing", "Mining", "Botany", "Weather", "Alarms")
        CategoryTags = @("Jobs", "Utility")
        RepoUrl = "https://github.com/FFXIV-CombatReborn/GatherBuddyReborn"
        IconUrl = "https://raw.githubusercontent.com/FFXIV-CombatReborn/RebornAssets/main/IconAssets/GBR_Icon.png"
    },
    @{
        SourceName = "vnavmesh"
        Version = "0.6.5.0"
        Manifest = "vnavmesh.json"
        Asset = "vnavmesh.zip"
        Author = "veyn, AtmoOmen, Codex(中文整理)"
        Name = "导航寻路基础"
        Punchline = "本地导航网格与自动寻路基础。"
        Description = "提供导航网格、路径计算和移动基础能力，供采集、任务和后续行动类工具调用。"
        Tags = @("Navigation", "Utility")
        CategoryTags = @("Utility")
        RepoUrl = "https://github.com/AtmoOmen/ffxiv_navmesh-cn"
        IconUrl = "https://raw.githubusercontent.com/AtmoOmen/ffxiv_navmesh-cn/CN/Resources/icon2.png"
    }
)

New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null
$packageRoot = Join-Path $OutputRoot "packages"
New-Item -ItemType Directory -Force -Path $packageRoot | Out-Null

$results = foreach ($plugin in $plugins) {
    $source = Join-Path $installedRoot (Join-Path $plugin.SourceName $plugin.Version)
    if (!(Test-Path -LiteralPath $source)) {
        throw "未找到已安装插件目录: $source"
    }

    $work = Join-Path $OutputRoot ("work\" + $plugin.SourceName)
    if (Test-Path -LiteralPath $work) {
        Remove-Item -LiteralPath $work -Recurse -Force
    }
    New-Item -ItemType Directory -Force -Path $work | Out-Null
    Get-ChildItem -LiteralPath $source -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $work -Recurse -Force
    }

    $manifestPath = Join-Path $work $plugin.Manifest
    if (!(Test-Path -LiteralPath $manifestPath)) {
        throw "未找到插件 manifest: $manifestPath"
    }

    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    $manifest.Author = $plugin.Author
    $manifest.Name = $plugin.Name
    $manifest.Punchline = $plugin.Punchline
    $manifest.Description = $plugin.Description
    $manifest.AssemblyVersion = $plugin.Version
    $manifest.RepoUrl = $plugin.RepoUrl
    $manifest.DownloadLinkInstall = "$downloadBase/$($plugin.Asset)"
    $manifest.DownloadLinkUpdate = "$downloadBase/$($plugin.Asset)"
    $manifest.DownloadLinkTesting = $null
    $manifest.Tags = $plugin.Tags
    $manifest.CategoryTags = $plugin.CategoryTags
    $manifest.IconUrl = $plugin.IconUrl
    $manifest.Disabled = $false
    $manifest.Testing = $false
    $manifest.ScheduledForDeletion = $false
    $manifest.InstalledFromUrl = ""
    $manifest.IsThirdParty = $true

    $manifest | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $manifestPath -Encoding UTF8

    $zipPath = Join-Path $packageRoot $plugin.Asset
    if (Test-Path -LiteralPath $zipPath) {
        Remove-Item -LiteralPath $zipPath -Force
    }
    Compress-Archive -Path (Join-Path $work "*") -DestinationPath $zipPath -Force
    $hash = Get-FileHash -Algorithm SHA256 -LiteralPath $zipPath
    $item = Get-Item -LiteralPath $zipPath

    [pscustomobject]@{
        Name = $plugin.Name
        InternalName = $manifest.InternalName
        AssemblyVersion = $manifest.AssemblyVersion
        Asset = $plugin.Asset
        Zip = $zipPath
        Size = $item.Length
        Sha256 = $hash.Hash.ToLowerInvariant()
        Download = "$downloadBase/$($plugin.Asset)"
    }
}

$results | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $OutputRoot "package-report.json") -Encoding UTF8
$results | Format-Table -AutoSize
Write-Host "输出目录: $OutputRoot"
