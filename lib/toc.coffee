#
#  As the markdown-toc library is very hard to use
#  I decide to write a markdown-toc library by myself
#
uslug = require 'uslug'

nPrefix = (str, n)->
  output = ''
  for i in [0...n]
    output += str
  return output


#
# eg:
#
# Haha [A](www.a.com) xxx [B](www.b.com)
#  should become
# Haha A xxx B
#
# check issue #41
#

sanitizeContent = (content)->
  output = ''
  offset = 0

  # test ![...](...)
  # test [...](...)
  ## <a name="myAnchor"></a>Anchor Header
  # test [^footnote]
  r = /\!?\[([^\]]*)\]\(([^)]*)\)|<([^>]*)>([^<]*)<\/([^>]*)>|\[\^([^\]]*)\]/g
  match = null
  while match = r.exec(content)
    output += content.slice(offset, match.index)
    offset = match.index + match[0].length

    if match[0][0] == '<'
      output += match[4]
    else if match[0][0] == '[' and match[0][1] == '^' # footnote
      output += ''
    else if match[0][0] != '!'
      output += match[1]
    else # image
      output += match[0]

  output += content.slice(offset, content.length)
  return output

###
opt =
  ordered: boolean
  depthFrom: number, default 1
  depthTo: number, default 6
  tab: string, default '\t'
tokens = [{content:String, level:Number, id:Optional|String }]
###
toc = (tokens, opt={})->
  if !tokens
    return {content: '', array: []}

  ordered = opt.ordered
  depthFrom = opt.depthFrom or 1
  depthTo = opt.depthTo or 6
  tab = opt.tab or '\t'

  if ordered
    tab = '    '

  tokens = tokens.filter (token)->
    token.level >= depthFrom and token.level <= depthTo

  if !(tokens.length)
    return {content: '', array: []}

  outputArr = []
  tocTable = {}
  smallestLevel = tokens[0].level

  # get smallestLevel
  for i in [0...tokens.length]
    if tokens[i].level < smallestLevel
      smallestLevel = tokens[i].level

  for i in [0...tokens.length]
    token = tokens[i]
    content = token.content
    level = token.level
    slug = token.id or uslug(content)

    if tocTable[slug] >= 0
      tocTable[slug] += 1
      slug += '-' + tocTable[slug]
    else
      tocTable[slug] = 0

    listItem = "#{nPrefix(tab, level-smallestLevel)}#{if ordered then "1." else '*'} [#{sanitizeContent(content)}](##{slug})"
    outputArr.push(listItem)

  return {
    content: outputArr.join('\n'),
    array: outputArr
  }

module.exports = toc
