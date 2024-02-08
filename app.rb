class App < Sinatra::Base

    def db
        if @db == nil
            @db = SQLite3::Database.new('./db/db.sqlite')
            @db.results_as_hash = true
        end
        return @db
    end

    get '/' do
        erb :'filmreviews/login'
    end

    get '/new' do

        erb :'filmreviews/new'
    end

    post '/films/new' do 
        name = params['name'] 
        description = params['description']
        query = 'INSERT INTO films (name, description) VALUES (?, ?) RETURNING *'
        result = db.execute(query, name, description).first 
        redirect "/fruits/#{result['id']}" 
    end

    get '/films' do
        @films = db.execute('SELECT * FROM films;')
        erb :'filmreviews/films'
    end

    get '/films/:id' do |id|
        @films = db.execute('SELECT * FROM films WHERE id = ?', id).first
        erb :'filmreviews/filmdesc'
    end

    
end