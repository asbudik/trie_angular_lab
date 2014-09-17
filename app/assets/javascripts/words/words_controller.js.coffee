WordCtrls = angular.module("WordCtrls", [])

class WordsCtrl
  @arrayWords = []
  Trie = (value) ->
    @characters = {}
    @value = value or ""
    return

  Trie = (value) ->
    @characters = {}
    @value = value or ""
    return

  Trie::learn = (word, index) ->
    index = 0  unless index
    if word[index]
      unless this.characters[word[index]]
        this.characters[word[index]] = new Trie(word[index])
        console.log(this.characters[word[index]])
        this.characters[word[index]].learn word, index + 1
      else
        this.characters[word[index]].learn word, index + 1
    else
      this.isWord = true
    return

  Trie::isEmpty = () ->
    this.characters is {} and @value is ""

  Trie::getWords = (prefix) ->
    wordsToReturn = []
    prefix = ""  unless prefix
    if this.isEmpty()
      return wordsToReturn
    else
      wordsToReturn.push prefix + @value  if this.isWord
      console.log(wordsToReturn)
      for key of this.characters
        console.log("key", key)
        wordsToReturn = wordsToReturn.concat(this.characters[key].getWords(prefix + this.value))
        console.log(wordsToReturn)
      return wordsToReturn


  Trie::find = (word, index) ->
    index = 0  unless index
    if (word.length - 1) is index
      @characters[word[index]]
    else unless @characters[word[index]]
      false
    else
      @characters[word[index]].find word, index + 1
  

  Trie::autoComplete = (prefix) ->
    findWords = @find(prefix)
    unless findWords
      []
    else
      findWords.getWords prefix.slice(0, -1)

  trie = new Trie()




  constructor: (@scope, @Word, @Trie) ->
    @greeting = "hello world"
    @getWords = []
    @Word.all().success (data) =>
      @arrayWords = data
      for word in @arrayWords
        trie.learn(word.name)

    @getWords = trie.getWords('ga')
    console.log(@getWords)


  addWord: (newWord) ->
    @Word.create(newWord).success (data) =>
      @arrayWords.push(data)
      @scope.newWord = {}

  sayHello: () ->
    "Hello there again"

WordCtrls.controller("WordsCtrl", ["$scope", "Word", "Trie", WordsCtrl])