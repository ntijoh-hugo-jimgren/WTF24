class App < Sinatra::Base

    enable :sessions

    def db
        if @db == nil
            @db = SQLite3::Database.new('./db/db.sqlite')
            @db.results_as_hash = true
        end
        return @db
    end

    get '/' do
        erb :'films/index'
    end

    get '/login' do
        erb :'films/login'
    end

    get '/registrate' do
        erb :'films/registrate'
    end

    get '/films/new' do

        erb :'films/new'
    end

    post '/films/new' do 
        title = params['title'] 
        description = params['description']
        query = 'INSERT INTO films (title, description) VALUES (?, ?) RETURNING *' 
        result = db.execute(query, title, description).first 
        redirect "/films/#{result['id']}" 
    end

    get '/films' do
        @films = db.execute('SELECT * FROM films')
        erb :'films/films'
    end

    get '/films/:id' do |id|
        @films = db.execute('SELECT * FROM films WHERE id = ?', id).first
        erb :'films/filmdesc'
    end

    post '/films/:id/delete' do |id| 
        db.execute('DELETE FROM films WHERE id = ?', id)
        redirect "/films"
    end

    get '/films/:id/edit' do |id| 
        @films = db.execute('SELECT * FROM films WHERE id = ?', id.to_i).first
        erb :'films/edit'
    end

    post '/films/:id/update' do |id| 
        title = params['title']
        description = params['description']
        db.execute('UPDATE films SET title = ?, description = ? WHERE id = ?', title, description, id)
        redirect "/films/#{id}" 
      end
    
end