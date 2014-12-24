{
    Story
    Character
    NarratorSentence
    DialogSentence
    CommentSentence
} = require "./elements"


parseFullText = (fullText) ->
    charTable = {}
    sentenceStream = []
    for l in (fullText.split "\n")
        parseEachLine l, charTable, sentenceStream
    new Story (charTable[idx] for idx of charTable), sentenceStream

parseEachLine = (line, charTable, sentenceStream) ->
# まずはざっと判別
    switch (line.charAt 0)
        when '-', '*'
            if m = line.match /^[-*] ?(\d+) ([^ 　#＃\t]*)/
                charTable[m[1]] = new Character m[2]
                return
        when '#', '＃'
            sentenceStream.push new CommentSentence line
            return
    if m = line.match /^(\d+)[ 　]+([^ 　#＃\t]*)/
        if c = charTable[m[1]]
            sentenceStream.push new DialogSentence m[2], c
        else
            throw "Character indexed or aliased as #{m[1]} is undefined."
        return
    sentenceStream.push new NarratorSentence line

module.exports = parseFullText
