Rails.application.routes.draw do
  get '/data', to: 'data#perform'
end
