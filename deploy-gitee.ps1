# Gitee Pages 部署辅助脚本
# 使用前请把下面的 GITEE_USER 改成你的 Gitee 用户名

$GITEE_USER = "XiaoMinghu"
$REPO_NAME = "work-report"
$REMOTE_URL = "git@gitee.com:XiaoMinghu/work-report.git"

if ($GITEE_USER -eq "") {
    Write-Host "请先在 deploy-gitee.ps1 中把 GITEE_USER 改成你的 Gitee 用户名" -ForegroundColor Red
    exit 1
}

Set-Location $PSScriptRoot

$remote = git remote get-url gitee 2>$null
if (-not $remote) {
    git remote add gitee $REMOTE_URL
    Write-Host "已添加远程仓库: $REMOTE_URL"
}

git add index.html README.md deploy-gitee.ps1

$status = git status --porcelain
if ($status) {
    git commit -m "deploy: 更新工作汇报生成器"
}

git push -u gitee master

Write-Host ""
Write-Host "代码已推送到 Gitee。" -ForegroundColor Green
Write-Host "接下来请手动操作：" -ForegroundColor Yellow
Write-Host "  1. 打开 https://gitee.com/$GITEE_USER/$REPO_NAME"
Write-Host "  2. 服务 -> Gitee Pages -> 分支选 master -> 勾选强制 HTTPS -> 启动/更新"
Write-Host "  3. 访问 https://$GITEE_USER.gitee.io/$REPO_NAME/"
