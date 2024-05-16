class App < Sinatra::Base

    enable :sessions

    helpers do
        def h(text)
          Rack::Utils.escape_html(text)
        end
      
        def hattr(text)
          Rack::Utils.escape_path(text)
        end
    end

    before do
        if session[:user_id]
            @user = db.execute('SELECT * FROM users WHERE id = ?', session[:user_id]).first
            @access_level = @user['access_level']
        end
    end

    def db
        if @db == nil
            @db = SQLite3::Database.new('./db/db.sqlite')
            @db.results_as_hash = true
        end
        return @db
    end

    get '/' do
        erb :'/index'
    end

    get '/login' do
        erb :'/login'
    end

    post '/login' do
        username = params['username']
        cleartext_password = params['password'] 

        user = db.execute('SELECT * FROM users WHERE username = ?', username).first

        if user == nil
            redirect "/register"
        end

        password_from_db = BCrypt::Password.new(user['hashed_pass'])

        if password_from_db == cleartext_password 
            session[:user_id] = user['id'] 
            redirect "/films"
        else
            redirect "/login"
        end
    end

    get '/register' do
        erb :'/register'
    end

    post '/register' do
        username = params['username']
        cleartext_password = params['password'] 
        hashed_pass = BCrypt::Password.create(cleartext_password)
        access_level = 1
        
        user_check = db.execute('SELECT * FROM users WHERE username = ?', username)
        if user_check == []
            query = 'INSERT INTO users (username, hashed_pass, access_level) VALUES (?,?,?)'
            result = db.execute(query, username, hashed_pass, access_level).first 
            redirect "/login"
        else
            redirect "/register"
        end
    end

    get '/new' do

        erb :'/new'
    end

    post '/new' do 
        title = params['title'] 
        description = params['description']
        if @access_level >= 1
            query = 'INSERT INTO films (title, description) VALUES (?, ?) RETURNING *' 
            result = db.execute(query, title, description).first 
        end
        redirect "/#{result['id']}" 
    end

    get '/films' do
        @films = db.execute('SELECT * FROM films')
        erb :'/films'
    end

    get '/:id' do |id|
        @films = db.execute('SELECT * FROM films WHERE id = ?', id).first
        erb :'/filmdesc'
    end

    post '/:id/delete' do |id| 
        if @access_level == 2
            db.execute('DELETE FROM films WHERE id = ?', id)
        end
        redirect "/films"
    end

    get '/:id/edit' do |id| 
        if @access_level == 2
            @films = db.execute('SELECT * FROM films WHERE id = ?', id.to_i).first
        end
        erb :'/edit'
    end

    post '/:id/update' do |id| 
        title = params['title']
        description = params['description']
        if @access_level == 2
            db.execute('UPDATE films SET title = ?, description = ? WHERE id = ?', title, description, id)
        end
        redirect "/#{id}" 
    end

    post '/:id/delete_user' do |id| 
        if @access_level >= 1
            db.execute('DELETE FROM users WHERE id = ?', id)
        end
        session.destroy
        redirect "/"
    end

    get '/delete_user' do

        erb :'/delete_user'
    end

    post '/delete_other_user' do
        username = params['username']
        if @access_level == 2
            db.execute('DELETE FROM users WHERE username = ?', username)
        end
        redirect "/films"
    end

    post '/logout' do
        session.destroy
        redirect "/"
    end
    
end