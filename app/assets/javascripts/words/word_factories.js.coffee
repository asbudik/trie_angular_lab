WordFactories = angular.module("WordFactories", [])

class Word

  # function Word(http) {
  #   this.http = http
  # }

  # Word.prototype.all = function() {
  #   this.http.get("/words.json")
  # }

  # Word.prototype.create = function(newWord) {
  #   this.http.post(...)
  # }

  constructor: (@http) ->
    
  all: () ->
    @http.get("/words.json")

  create: (newWord) ->
    @http.post("/words.json", {word: newWord})


WordFactories.service("Word", ["$http", Word])


class Trie
  constructor: () ->
    this.characters = {}

  learn:  (word, index) ->

    index = index or 0
    if index is word.length
      @isWord = true
    else if index < word.length
      char = word[index]
      subTrie = @characters[char] or new Trie()
      subTrie.learn word, index + 1
      @characters[char] = subTrie

  getWords: (words, currentWord) ->


    currentWord = currentWord or ""
    words = words or []
    words.push currentWord  if @isWord
    for char of @characters
      nextWord = currentWord + char
      @characters[char].getWords words, nextWord
      return words;

  find: (word, index) ->


    index = index or 0
    char = word[index]
    if index < word.length - 1 and @characters[char]
      index += 1
      @characters[char].find word, index
    else
      @characters[char]

  autoComplete: (prefix) ->

    subTrie = @find(prefix)
    if subTrie
      return subTrie.getWords [], prefix
    else
      return []

  WordFactories.service("Trie", [Trie])