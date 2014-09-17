Rails.application.routes.draw do
  get 'words/index'

  get 'words/create'

  get 'words/show'

  get 'words/update'

  get 'words/destroy'

  get 'word_templates/index'

  root to: "words#index"
  resources :words, except: [:edit, :new]
  resources :word_templates
end
