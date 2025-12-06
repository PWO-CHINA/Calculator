# ChemLab Pro 开发指南

恭喜！你的项目已经升级为现代化的 Web 开发架构。

## 1. 快速开始

你需要先安装依赖（即你提到的“插件”）：

1. 打开终端（在当前文件夹右键 -> "Open in Terminal" 或 VS Code 中按 `Ctrl + ~`）
2. 输入以下命令并回车：
   ```bash
   npm install
   ```
   *这会根据 package.json 下载 Vite, Tailwind CSS 等工具到 node_modules 文件夹。*

## 2. 启动开发服务器

在开发修改代码时，请使用以下命令启动预览：

```bash
npm run dev
```

*   你会看到一个类似 `http://localhost:5173` 的地址。
*   **按住 Ctrl 点击该链接**，在浏览器中查看你的网站。
*   现在，当你修改 `index.html` 或 `src/style.css` 并在保存时，浏览器会**自动刷新**，无需手动刷新！

## 3. 构建发布

当你准备将网站发布给别人使用（或上传到服务器）时：

```bash
npm run build
```

*   这会生成一个 `dist` 文件夹。
*   `dist` 文件夹中的内容是最终的网页，可以直接部署。

## 4. 常见问题

*   **原来的计算器还能用吗？**
    可以！在 `npm run dev` 启动的网页中，点击原来的链接（如“盐酸标准溶液配制”）即可跳转。我们已经配置好了一切。

*   **可以直接双击 `index.html` 打开吗？**
    **不可以**。因为使用了现代化的模块化开发（`<script type="module">`），浏览器为了安全，不允许直接打开本地文件运行。必须使用 `npm run dev` 或 `npm run preview`。

*   **我想修改样式？**
    去 `src/style.css` 修改，或者直接在 HTML 元素上使用 Tailwind 类名。

祝你编程愉快！
