protocolsWhiteList = atom.config.get('markdown-preview-enhanced.protocolsWhiteList').split(',').map((x)->x.trim()) or ['http', 'https', 'atom', 'file']
protocolsWhiteListRegExp = new RegExp('^(' + protocolsWhiteList.join('|')+')\:\/\/')  # eg /^(http|https|atom|file)\:\/\//

module.exports = {protocolsWhiteListRegExp, protocolsWhiteList}