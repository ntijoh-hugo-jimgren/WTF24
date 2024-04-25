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
    db.execute('DROP TABLE IF EXISTS actors')
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
        "access_level"    INTEGER NOT NULL
    )')

    db.execute('CREATE TABLE "actors" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name"    TEXT NOT NULL UNIQUE,
    )')

    # db.execute('CREATE TABLE "comments" (
    #     "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    #     "content"    TEXT NOT NULL,
    #     "user_id"    INTEGER NOT NULL,
    #     "film_id"    INTEGER NOT NULL
    # )')

end

def seed_tables

    

end

drop_tables
create_tables
seed_tables