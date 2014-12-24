{
    DialogSentence
    NarratorSentence
    CommentSenence
} = require "./elements"

complie = (story, type = "text") ->
    typedBuilder = sentenceToPlainText
    if type.toLowerCase() == "html"
        typedBuilder = sentenceToHTML
    story.sentences.reduce (prev, crnt) ->
        prev + (typedBuilder crnt)
    , ""

sentenceToPlainText = (s) ->
    if s instanceof DialogSentence
        s.character.name + s.bracketStart + s.text + s.bracketEnd + "\n"
    else if s instanceof NarratorSentence
        s.text + "\n"
    else
        ""

sentenceToHTML = (s) ->
    if s instanceof DialogSentence
        "<p><span class='charname'>#{s.character.name}</span>#{s.bracketStart}#{s.text}#{s.bracketEnd}</p>\n"
    else if s instanceof NarratorSentence
        "<p>#{s.text}</p>\n"
    else
        ""


module.exports = complie
