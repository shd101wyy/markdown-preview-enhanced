'use strict'
/*
 * As the markdown-toc library is very hard to use
 * I decide to write a markdown-toc library by myself
 */
let uslug = require('uslug')

function nPrefix(str, n) {
  let output = ''
  for (let i = 0; i < n; i++) {
    output += str
  }
  return output
}

/*
 eg:

 Haha [A](www.a.com) xxx [B](www.b.com)
  should become
 Haha A xxx B

 check issue #41
 */
function sanitizeContent(content) {
  let output = '',
      offset = 0

  // test ![...](...)
  // test [...](...)
  let r = /\!?\[([^\]]*)\]\(([^)]*)\)/g
  let match = null
  while (match = r.exec(content)) {
    output += content.slice(offset, match.index)
    offset = match.index + match[0].length
    if (match[0][0] !== '!') {
      output += match[1]
    } else { // image
      output += match[0]
    }
  }

  output += content.slice(offset, content.length)
  return output
}

function toc(tokens) {
  if (!tokens || !tokens.length) return []

  let outputArr = [],
      tocTable = {},
      smallestLevel = tokens[0].level

  // get smallestLevel
  for (let i = 0; i < tokens.length; i++) {
    if (tokens[i].level < smallestLevel) {
      smallestLevel = tokens[i].level
    }
  }

  for (let i = 0; i < tokens.length; i++) {
    let token = tokens[i],
        content = token.content,
        level = token.level,
        slug = uslug(content)

        if (tocTable[slug] >= 0) {
          tocTable[slug] += 1
          slug += '-' + tocTable[slug]
        } else {
          tocTable[slug] = 0
        }

    let listItem = `${nPrefix('\t', level-smallestLevel)}- [${sanitizeContent(content)}](#${slug})`
    outputArr.push(listItem)
  }

  return {
    content: outputArr.join('\n'),
    array: outputArr
  }
}

module.exports = toc
