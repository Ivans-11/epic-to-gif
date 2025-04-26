<!-- 中文版本 -->
# EPIC地球多色成像相机图像获取脚本
[English](README.md)

## 功能概述
此脚本用于从NASA API获取地球的自然图像，支持指定日期下载，并可选择为下载的图像添加时间水印。最后，脚本会将下载的图像合成为GIF动画。

## 使用方法
### 基本用法
```bash
./getimg.sh
```
此命令将从当前日期开始尝试获取图像，如果当前日期没有图像，会自动回溯到前一天，直到找到图像为止。

### 可选参数
- `-d <date>`: 指定要获取图像的日期，格式为 `YYYY-MM-DD`。
- `-w`: 为下载的图像添加水印。

### 示例
```bash
./getimg.sh -d 2025-01-01 -w
```
此命令将尝试获取2025年1月1日的图像，并为下载的图像添加水印。

![2025-01-01动图示例](example/2025-01-01.gif)

## 所需依赖
- `curl`: 用于从NASA API获取数据和下载图像。
- `jq`: 用于解析JSON格式的API响应。
- `ImageMagick`: 用于为图像添加水印和生成GIF动画。在Windows系统中，需要使用 `magick` 命令；在Linux系统中，使用 `convert` 命令。

## 配置
在运行脚本前，需要将 `getimg.sh` 文件中的 `apikey` 变量替换为你自己的NASA API密钥。

```bash
# Replace with your NASA API key
apikey="YOUR_API_KEY_HERE"
```

## 输出结果
脚本会将下载的图像保存到 `img/<date>` 目录下，并在该目录下生成一个名为 `<date>.gif` 的GIF动画文件。

## 参考资料
本项目基于louis-e的工作。原始项目可在 [nasa-api-earthpolychromaticimagingcamera](https://github.com/louis-e/nasa-api-earthpolychromaticimagingcamera) 找到。