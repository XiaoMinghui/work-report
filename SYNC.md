# 云端同步部署说明

同步功能使用 **Cloudflare Workers + KV**，免费额度个人够用。

## 一次性配置

### 1. 安装依赖

```powershell
cd C:\Users\24332\Projects\work-report
npm install
```

### 2. 登录 Cloudflare

```powershell
npx wrangler login
```

### 3. 创建 KV 命名空间

```powershell
npm run kv:create
```

命令会输出类似：

```text
id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

把 `wrangler.toml` 里 `REPLACE_WITH_KV_NAMESPACE_ID` 替换成这个 id。

### 4. 部署

```powershell
npm run deploy
```

部署后访问你的 `*.workers.dev` 地址，在页面「云端同步」栏设置同步码即可。

## 使用说明

1. 首次在一台设备输入 **4～32 位字母数字同步码**，点「启用同步」
2. 同步码会保存在本机，下次打开自动同步
3. 其他设备输入**同一个同步码**，即可拉取同一份数据
4. 修改内容约 1 秒后自动上传到云端
5. 点「退出同步」可清除本机同步码（云端数据保留）

## 更新网站

```powershell
git pull
npm run deploy
```

若通过 GitHub 连 Cloudflare 自动部署，推送代码后还需确认 Worker 绑定 KV（Dashboard → Workers → 你的项目 → Settings → Bindings）。
