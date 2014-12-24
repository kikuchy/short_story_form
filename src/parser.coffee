{
    Story
    Character
    NarratorSentence
    DialogSentence
    CommentSentence
} = require "./elements"


parseFullText = (fullText) ->
    charIndexTable = {}
    charAliasTable = {}
    sentenceStream = []
    for l in (fullText.split "\n")
        parseEachLine l, charIndexTable, charAliasTable, sentenceStream
    new Story (charIndexTable[idx] for idx of charIndexTable), sentenceStream

parseEachLine = (line, charIndexTable, charAliasTable, sentenceStream) ->
# まずはざっと判別
    switch (line.charAt 0)
        when '-', '*'
            if m = line.match /^[-*] ?(\d+) ([^ 　#＃\t]*)[ 　\t]?([^ 　#＃\t]*)/
                charIndexTable[m[1]] = new Character m[2]
                charAliasTable[m[3]] = charIndexTable[m[1]] if m[3]
                return
        when '#', '＃'
            sentenceStream.push new CommentSentence line
            return
    if m = line.match /^(.+?)([:：;； 　]+)([^ 　#＃\t]*)/
        if c = charIndexTable[m[1]] or c = charAliasTable[m[1]]
            if m[2].match /[;；]/
                sentenceStream.push new DialogSentence m[3], c, "（", "）"
            else
                sentenceStream.push new DialogSentence m[3], c
        else
            throw "Character indexed or aliased as #{m[1]} is undefined."
        return
    sentenceStream.push new NarratorSentence line

module.exports = parseFullText
