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
    db.execute('DROP TABLE IF EXISTS users')
    db.execute('DROP TABLE IF EXISTS words')
end

def create_tables

    db.execute('CREATE TABLE films(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT
    )')

    db.execute('CREATE TABLE "users" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "username"    TEXT NOT NULL UNIQUE,
        "hashed_pass"    TEXT NOT NULL,
        "access_level"    INTEGER NOT NULL,
        "salt_key" TEXT NOT NULL
    )')

    db.execute('CREATE TABLE "words" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "text"    TEXT NOT NULL
    )')

end

def seed_tables

    

end

drop_tables
create_tables
seed_tables