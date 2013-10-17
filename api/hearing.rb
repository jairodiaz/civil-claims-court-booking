class Hearing < Grape::API
  format :json

  post '/hearing' do
    puts 'we are hearing'
    { :ping => "pong" }
  end
end
