# Atom 版本安装教程

> 感谢 [@zangchendi](https://github.com/zangchendi) 编写此文档.

> 请确保已禁用掉官方的 `markdown-preview` 插件

安装方法有很多，推荐用户根据个人情况（墙内/墙外）自行选择。

## 软件内安装（墙外推荐）

打开 **atom** 编辑器，打开 `Settings` 设置（默认为<kbd>cmd+,</kbd>键)，然后点击 `install` 安装，搜索 `markdown-preview-enhanced`。
安装完成后，必须**重启** atom 使之生效。
推荐在安装完成后在 `Settings` 中点击 `Disable` 关闭系统内置安装的`markdown-preview`，防止冲突。
![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Terminal 终端安装（墙内可以尝试）

打开终端，运行如下命令：

```bash
apm install markdown-preview-enhanced
```

如果是墙内用户，可以先尝试运行如下命令测试网络状况：

```bash
apm install check
```

如果`Installing check to /.atom/packages`后面很快出现一个对号，则证明可以使用命令行安装。
注：校园网用户可能比较容易安装，此外防火墙也经常会抽风导致安装成功。
注 2：墙内用户用户默认已经安装 npm 并设置国内淘宝镜像。如果没有，请参照下文安装。

> **关于墙内 npm 安装**
>
> 运行如下命令使用淘宝镜像安装 npm：
>
> ```bash
> npm install -g cnpm --registry=https://registry.npm.taobao.org
> ```
>
> 可以通过`cnpm -v`查看版本命令查看是否安装成功。
> 此后就可以使用`cnpm`代替`npm`命令
>
> 之后需要对 `.atom` 文件夹内 `.atomrc` 进行配置：
> 打开 `.atomrc` 文件（如不存在请自行创建），输入如下内容并保存
>
> ```
> registry=https://registry.npm.taobao.org
> strict-ssl = false
> ```

## GitHub 安装（墙内推荐）

- `cd` 到 `.atom/packages` 文件夹
- `Clone` 整个项目
- `cd` 到下载的 **markdown-preview-enhanced** 文件夹
- 运行 `yarn install` 命令。墙内用户可以使用 `cyarn install` 命令。

```bash
cd ~/.atom/packages
git clone https://github.com/shd101wyy/markdown-preview-enhanced
cd markdown-preview-enhanced
yarn install
```

墙内用户如果没有安装 `npm` 命令，可以参照终端安装内的**关于墙内 npm 安装**

## 对于开发人员

```bash
apm develop markdown-preview-enhanced
```

- 在**Atom**编辑器中通过 **View->Developer->Open in Dev Mode...** 打开 **markdown-preview-enhanced** 文件夹
- 然后您就可以修改代码
  每次更新代码，您都需要通过 <kbd>cmd-shift-p</kbd> 键搜索选择 `Window: Reload` 重新载入项目。

[➔ 使用](zh-cn/usages.md)
