# frozen_string_literal: true

Rails.application.routes.draw do
  resources :vacancies, only: %i[index new create] do
    # BEGIN
    member do
      patch 'publish', to: 'vacancies#publish_vacancy', as: :publish
      patch 'archive', to: 'vacancies#archive_vacancy', as: :archive
    end
    # END
  end

  root 'vacancies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
