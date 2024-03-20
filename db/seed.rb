require 'sqlite3'

def db
    if @db == nil
        @db = SQLite3::Database.new('./db/db.sqlite')
        @db.results_as_hash = true
    end
    return @db
end

def drop_tables
    db.execute('DROP TABLE IF EXISTS films')
end

def create_tables

    db.execute('CREATE TABLE films(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        desecription TEXT
    )')

end

def seed_tables

    films = [
        {title: 'Bamse', description: '0709476442'},
        {title: 'Björnbert', description: '0726414635'},
        {title: 'Erick', description: '011953259340'},
        {title: 'MrMilk', description: '0735141514'}
    ]

    films.each do |film|
        db.execute('INSERT INTO films (title, description) VALUES (?,?)', film[:title], film[:description])
    end

end

drop_tables
create_tables
seed_tables