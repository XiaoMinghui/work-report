# Cloudflare Pages 部署指南

账号信息：
- GitHub 用户名：`XiaoMinghui`
- 邮箱：`2433216985@qq.com`
- 仓库名：`work-report`

---

## 第一步：在 GitHub 创建仓库

1. 用邮箱 `2433216985@qq.com` 登录 https://github.com
2. 打开 https://github.com/new
3. 填写：
   - Repository name：`work-report`
   - 选择 **Public**（公开）
   - **不要**勾选 "Add a README file"
4. 点击 **Create repository**

---

## 第二步：推送代码到 GitHub

在项目目录执行：

```powershell
cd C:\Users\24332\Projects\work-report
.\deploy-cloudflare.ps1
```

首次推送时，浏览器会弹出 GitHub 登录/授权窗口，按提示完成即可。

推送成功后，代码地址：https://github.com/XiaoMinghui/work-report

> 说明：本机通过 HTTPS 推送（需开启代理 127.0.0.1:7890）。SSH 方式需先在 GitHub 添加公钥。

---

## 第三步：在 Cloudflare Pages 部署

1. 打开 https://dash.cloudflare.com
2. 注册或登录（建议用同一邮箱，方便管理）
3. 左侧菜单 → **Workers & Pages**
4. 点击 **Create** → 选 **Pages** 标签 → **Connect to Git**
5. 点击 **Connect GitHub**，授权 Cloudflare 访问你的 GitHub
6. 选择仓库 **`XiaoMinghui/work-report`**
7. 构建设置（重要）：

| 配置项 | 填写内容 |
|--------|----------|
| Project name | `work-report`（可自定义） |
| Production branch | `master` |
| Framework preset | **None** |
| Build command | **留空** |
| Build output directory | `/` |

8. 点击 **Save and Deploy**
9. 等待 1～2 分钟，状态变为 Success

---

## 第四步：访问你的网站

部署成功后，访问地址类似：

```
https://work-report.pages.dev
```

（具体子域名以 Cloudflare 分配为准，在项目 Overview 页面可见）

手机浏览器打开后，可「添加到主屏幕」，每天点开填写汇报。

---

## 以后更新网站

修改代码后执行：

```powershell
git add .
git commit -m "update: 描述修改内容"
git push github master
```

Cloudflare 会自动检测推送并重新部署，通常 1～2 分钟生效。

同时推送到 Gitee（可选）：

```powershell
git push gitee master
```

---

## 常见问题

**Q：Cloudflare 连不上 GitHub？**  
在 Cloudflare 授权页面重新 Connect GitHub，确保勾选了 `work-report` 仓库访问权限。

**Q：部署后打开是 404？**  
检查 Build output directory 是否为 `/`，且仓库根目录有 `index.html`。

**Q：国内访问慢？**  
Cloudflare 有全球 CDN，一般比 GitHub Pages 快。若仍慢，可在 Cloudflare 项目设置里开启缓存优化。

**Q：Gitee Pages 还能用吗？**  
不能，已于 2024 年 5 月下线。Gitee 仅作代码备份，网站发布用 Cloudflare Pages。
