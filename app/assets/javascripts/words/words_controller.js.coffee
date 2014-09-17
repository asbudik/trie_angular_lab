WordCtrls = angular.module("WordCtrls", [])

class WordsCtrl

  constructor: (@scope) ->
    @greeting = "hello world"

  sayHello: () ->
    "Hello there again"

WordCtrls.controller("WordsCtrl", ["$scope", WordsCtrl])