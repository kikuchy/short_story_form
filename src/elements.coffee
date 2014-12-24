class Story
    constructor: (@characters, @sentences)->


class Sentence
    constructor: (@text) ->


class Character
    constructor: (@name) ->


class DialogSentence extends Sentence
    constructor: (@text, @character) ->
        super @text


class CommentSentence extends Sentence
    constructor: (@text) ->
        super @text


class NarratorSentence extends Sentence
    constructor: (@text) ->
        super @text


module.exports = {
    Story
    Character
    Sentence
    NarratorSentence
    DialogSentence
    CommentSentence
}

