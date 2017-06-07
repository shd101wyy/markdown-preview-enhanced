# Markdown 基本要素
這篇文件意在簡要介紹 [GitHub Flavored Markdown 寫作](https://guides.github.com/features/mastering-markdown/)。      

## 什麼是 Markdown?  
`Markdown` 是一種文本格式。你可以用它來控制文檔的顯示。使用 markdown，你可以創建粗體的文字，斜體的文字，添加圖片，並且創建列表 等等。基本上來講，Markdown 就是普通的文字加上 `#` 或者 `*` 等符號。  

## 語法說明

### 標題
```markdown
# 這是 <h1> 一級標題
## 這是 <h2> 二級標題
### 這是 <h3> 三級標題
#### 這是 <h4> 四級標題
##### 這是 <h5> 五級標題
###### 這是 <h6> 六級標題
```

如果你想要給你的標題添加 `id` 或者 `class`，請在標題最後添加 `{#id .class1 .class2}`。例如：  
```markdown
# 這個標題擁有 1 個 id {#id1}
# 這個標題有 2 個 classes {.class1 .class2}
```
> 這是一個 MPE 擴展的特性。  

### 強調
```markdown
*這會是 斜體 的文字*
_這會是 斜體 的文字_

**這會是 粗體 的文字**
__這會是 粗體 的文字__

_你也 **組合** 這些符號_

~~這個文字將會被橫線刪除~~
```

### 列表
#### 無序列表
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

### 添加圖片  
```markdown
![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)
```

### 鏈接  
```markdown
http://github.com - 自動生成！
[GitHub](http://github.com)
```

### 引用
```markdown
正如 Kanye West 所說：

> We're living the future so
> the present is our past.

```

### 分割線  
```markdown
如下，三個或者更多的

---

連字符

***

星號

___

下劃線
```

### 行內代碼
```markdown  
我覺得你應該在這裡使用
`<addr>` 才對。
```

### 代碼塊
你可以在你的代碼上面和下面添加 <code>\`\`\`</code> 來表示代碼塊。

#### 語法高亮
你可以給你的代碼塊添加任何一種語言的語法高亮  

例如，給 ruby 代碼添加語法高亮：

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

會得到下面的效果：

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### 代碼塊 class（MPE 擴展的特性）
你可以給你的代碼塊設置 `class`。

例如，添加 `class1 class2` 到一個 代碼塊：

    ```javascript {.class1 .class2}
    function add(x, y) {
      return x + y
    }
    ```

##### 代碼行數
如果你想要你的代碼塊顯示代碼行數，只要添加 `lineNo` class 就可以了。

例如：

    ```javascript {.lineNo}
    function add(x, y) {
      return x + y
    }
    ```

將會得到下面的顯示效果：

![Screen Shot 2017-05-27 at 6.10.10 PM](http://i.imgur.com/5wfq8Uq.png)


### 任務列表   
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

### 腳注
```markdown
Content [^1]

[^1]: Hi! This is a footnote
```

## References
* [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
* [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)


[➔ 數學](zh-tw/math.md)