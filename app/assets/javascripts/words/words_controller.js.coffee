WordControllers = angular.module("WordControllers", [])

class WordsCtrl
  
  constructor: (@scope, @http, @Word, @Trie) ->
    @greeting = "hello world"
    @getWords = []
    @Word.all().success (data) =>
      @arrayWords = data


  addWord: (newWord) ->
    @Trie.learn(newWord.name)
    console.log(@Trie)
    @Word.create(newWord).success (data) =>
      @arrayWords.push(data)
      @scope.newWord = {}

  sayHello: () ->
    "Hello there again"

WordControllers.controller("WordsCtrl", ["$scope", "$http", "Word", "Trie", WordsCtrl])