{
    DialogSentence
    NarratorSentence
    CommentSenence
} = require "./elements"

complie = (story) ->
    story.sentences.reduce (prev, crnt) ->
        prev + (sentenceToString crnt)
    , ""

sentenceToString = (s) ->
    if s instanceof DialogSentence
        "#{s.character.name}「#{s.text}」" + "\n"
    else if s instanceof NarratorSentence
        s.text + "\n"
    else
        ""

module.exports = complie
