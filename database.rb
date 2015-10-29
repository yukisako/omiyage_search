require 'rubygems'
require 'sqlite3'


db = SQLite3::Database.new("learn.sqlite3")

db.execute("drop table if exists category;")
db.execute("create table category(name text)")

db.execute("insert into category (name) values ('yuki');")




=begin
sql = <<-SQL
CREATE TABLE learn_data(
  categpry text

);
SQL

db.execute_batch(sql)
=end

db.close
