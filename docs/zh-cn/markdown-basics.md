# Markdown 基本要素
这篇文件意在简要介绍 [GitHub Flavored Markdown 写作](https://guides.github.com/features/mastering-markdown/)。      

## 什么是 Markdown?  
`Markdown` 是一种文本格式。你可以用它来控制文档的显示。使用 markdown，你可以创建粗体的文字，斜体的文字，添加图片，并且创建列表 等等。基本上来讲，Markdown 就是普通的文字加上 `#` 或者 `*` 等符号。  

## 语法说明

### 标题
```markdown
# 这是 <h1> 一级标题
## 这是 <h2> 二级标题
### 这是 <h3> 三级标题
#### 这是 <h4> 四级标题
##### 这是 <h5> 五级标题
###### 这是 <h6> 六级标题
```

如果你想要给你的标题添加 `id` 或者 `class`，请在标题最后添加 `{#id .class1 .class2}`。例如：  
```markdown
# 这个标题拥有 1 个 id {#id1}
# 这个标题有 2 个 classes {.class1 .class2}
```
> 这是一个 MPE 扩展的特性。  

### 强调
```markdown
*这会是 斜体 的文字*
_这会是 斜体 的文字_

**这会是 粗体 的文字**
__这会是 粗体 的文字__

_你也 **组合** 这些符号_

~~这个文字将会被横线删除~~
```

### 列表
#### 无序列表
```markdown
* Item 1
* Item 2
  * Item 2a
  * Item 2b
```

#### 有序列表
```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

### 添加图片  
```markdown
![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)
```

### 链接  
```markdown
http://github.com - 自动生成！
[GitHub](http://github.com)
```

### 引用
```markdown
正如 Kanye West 所说：

> We're living the future so
> the present is our past.

```

### 分割线  
```markdown
如下，三个或者更多的

---

连字符

***

星号

___

下划线
```

### 行内代码
```markdown  
我觉得你应该在这里使用
`<addr>` 才对。
```

### 代码块
你可以在你的代码上面和下面添加 <code>\`\`\`</code> 来表示代码块。

#### 语法高亮
你可以给你的代码块添加任何一种语言的语法高亮  

例如，给 ruby 代码添加语法高亮：

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

会得到下面的效果：

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### 代码块 class（MPE 扩展的特性）
你可以给你的代码块设置 `class`。

例如，添加 `class1 class2` 到一个 代码块：

    ```javascript {.class1 .class2}
    function add(x, y) {
      return x + y
    }
    ```

##### 代码行数
如果你想要你的代码块显示代码行数，只要添加 `lineNo` class 就可以了。

例如：

    ```javascript {.lineNo}
    function add(x, y) {
      return x + y
    }
    ```

将会得到下面的显示效果：

![Screen Shot 2017-05-27 at 6.10.10 PM](http://i.imgur.com/5wfq8Uq.png)


### 任务列表   
```markdown  
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```

### 表格
```markdown  
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

### 脚注
```markdown
Content [^1]

[^1]: Hi! This is a footnote
```

## References
* [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
* [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)


[➔ 数学](zh-cn/math.md)