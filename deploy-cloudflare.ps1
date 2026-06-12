# Cloudflare Pages 部署辅助脚本
# GitHub 账号: XiaoMinghui (2433216985@qq.com)

$GITHUB_USER = "XiaoMinghui"
$REPO_NAME = "work-report"
$REMOTE_URL = "https://github.com/$GITHUB_USER/$REPO_NAME.git"

Set-Location $PSScriptRoot

$remote = git remote get-url github 2>$null
if (-not $remote) {
    git remote add github $REMOTE_URL
    Write-Host "已添加 GitHub 远程: $REMOTE_URL" -ForegroundColor Green
}

git add index.html README.md DEPLOY.md deploy-cloudflare.ps1 deploy-gitee.ps1

$status = git status --porcelain
if ($status) {
    git commit -m "docs: 添加 Cloudflare Pages 部署说明"
}

Write-Host ""
Write-Host "正在推送到 GitHub..." -ForegroundColor Cyan
git push -u github master

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "GitHub 推送成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "接下来在 Cloudflare 控制台操作：" -ForegroundColor Yellow
    Write-Host "  1. 打开 https://dash.cloudflare.com 并登录/注册"
    Write-Host "  2. 左侧 Workers & Pages -> Create -> Pages -> Connect to Git"
    Write-Host "  3. 授权 GitHub，选择仓库 $REPO_NAME"
    Write-Host "  4. 构建设置：Framework=None, Build command=留空, Output directory=/"
    Write-Host "  5. 点击 Save and Deploy"
    Write-Host "  6. 部署完成后访问 https://work-report.pages.dev"
} else {
    Write-Host ""
    Write-Host "推送失败，请检查：" -ForegroundColor Red
    Write-Host "  1. 是否已在 GitHub 创建空仓库: https://github.com/new"
    Write-Host "     仓库名: $REPO_NAME，公开，不要勾选 README"
    Write-Host "  2. 是否已登录 GitHub（浏览器）"
    Write-Host "  3. 重新运行: .\deploy-cloudflare.ps1"
}
