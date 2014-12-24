{
    Story
    Character
    NarratorSentence
    DialogSentence
    CommentSentence
} = require "./elements"


parseFullText = (fullText) ->
    charAliasTable = {}
    sentenceStream = []
    for l in (fullText.split "\n")
        parseEachLine l, charAliasTable, sentenceStream
    new Story (charAliasTable[als] for als of charAliasTable), sentenceStream

parseEachLine = (line, charAliasTable, sentenceStream) ->
    if m = line.match /^[-\*ー―＊][ 　\t]?([^ 　#＃\t]*)[ 　\t]?([^ 　#＃\t]*)/
        charAliasTable[m[1]] = new Character m[2]
        return
    if line.match /^[#＃]/
        sentenceStream.push new CommentSentence line
        return
    if m = line.match /^(.+?)([:：_＿ 　]+)([^ 　#＃\t]*)/
        if c = charAliasTable[m[1]]
            if m[2].match /[_＿]/
                sentenceStream.push new DialogSentence m[3], c, "（", "）"
            else
                sentenceStream.push new DialogSentence m[3], c
        else
            throw "Character aliased as '#{m[1]}' is undefined."
        return
    sentenceStream.push new NarratorSentence line

module.exports = parseFullText
