require 'sqlite3'

def db
    if @db == nil
        @db = SQLite3::Database.new('./db/db.sqlite')
        @db.results_as_hash = true
    end
    return @db
end

def drop_tables
    db.execute('DROP TABLE IF EXISTS plugs')
end

def create_tables

    db.execute('CREATE TABLE plugs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        number TEXT
    )')

end

def seed_tables

    plugs = [
        {name: 'Bamse', number: '0709476442'},
        {name: 'Björnbert', number: '0726414635'},
        {name: 'Erick', number: '011953259340'},
        {name: 'MrMilk', number: '0735141514'}
    ]

    plugs.each do |plug|
        db.execute('INSERT INTO plug (name, number) VALUES (?,?)', plug[:name], plug[:number])
    end

end

drop_tables
create_tables
seed_tables