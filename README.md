# 工作汇报生成器

单页静态工具：填写四个板块内容，按公司格式生成汇报文本，一键复制到微信群。

## Gitee Pages 部署（国内访问）

### 前置条件

1. 注册 [Gitee](https://gitee.com) 账号
2. 完成**实名认证**（未认证无法开通 Pages）
3. 本机已安装 Git

### 第一步：在 Gitee 创建仓库

1. 登录 Gitee → 右上角 **+** → **新建仓库**
2. 仓库名称建议：`work-report`
3. 选择 **公开**
4. **不要**勾选「使用 Readme 文件初始化」（避免和本地推送冲突）
5. 点击创建

### 第二步：推送代码到 Gitee

在项目目录打开终端，执行（把 `你的Gitee用户名` 换成你的实际用户名）：

```powershell
cd C:\Users\24332\Projects\work-report

git add index.html README.md
git commit -m "init: 工作汇报生成器"

git remote add gitee git@gitee.com:XiaoMinghu/work-report.git
git push -u gitee master
```

如果远程已存在，改用：

```powershell
git push -u gitee master
```

也可直接运行辅助脚本（需先改脚本里的用户名）：

```powershell
.\deploy-gitee.ps1
```

### 第三步：开启 Gitee Pages

1. 进入仓库页面 → 左侧或顶部 **服务** → **Gitee Pages**
2. 配置：
   - **分支**：`master`
   - **部署目录**：留空或填 `/`（根目录，因为 `index.html` 在仓库根目录）
   - 勾选 **强制使用 HTTPS**
3. 点击 **启动** 或 **更新**

### 第四步：访问你的网站

启动成功后，页面会显示访问地址，格式类似：

```
https://xiaominghu.gitee.io/work-report/
```

手机浏览器打开后，可添加到主屏幕，像 App 一样每天点开填写。

### 更新网站内容

Gitee Pages **免费版不会自动部署**，每次改完代码后需要：

1. 本地提交并推送到 Gitee：

```powershell
git add .
git commit -m "update: 描述本次修改"
git push gitee master
```

2. 回到 Gitee 仓库 → **服务** → **Gitee Pages** → 点击 **更新**

3. 手机上若看到旧页面，下拉刷新；或清除浏览器缓存后重试

## 注意事项

| 项目 | 说明 |
|------|------|
| 实名认证 | 通常 1 个工作日内审核，审核通过后才能开 Pages |
| 数据存储 | 姓名等数据存在用户浏览器 `localStorage`，换设备需重新填写 |
| 仓库可见性 | 必须是**公开仓库**才能使用免费 Pages |
| 自定义域名 | 免费版一般不支持，使用 `*.gitee.io` 即可 |

## 本地使用

不部署也可以：双击 `index.html` 用浏览器打开即可离线使用。
