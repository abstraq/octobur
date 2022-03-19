# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https: //opensource.org/licenses/MIT.

require "athena"
require "pg"

require "./abstract_user_repository"

# PostgreSQL implementation for `Octobur::Model::AbstractUserRepository`.
@[ADI::Register]
class Octobur::Model::PostgresUserRepository < Octobur::Model::AbstractUserRepository
  def initialize(@database : DB::Database); end

  def insert(user : Octobur::Model::User) : Nil
    query = <<-SQL
    INSERT INTO users (username, email, password_hash)
    VALUES ($1, $2, $3)
    RETURNING id, created_at;
    SQL

    user.before_save
    result = @database.query_one(query, user.username, user.email, user.password_hash, as: {Int64, Time})
    user.after_create(*result)
  end

  def find(id : Int64) : Octobur::Model::User?
    query = <<-SQL
    SELECT * FROM users WHERE id = $1;
    SQL

    @database.query_one?(query, as: Octobur::Model::User)
  end

  def exists(user : Octobur::Model::User) : Bool
    false
  end

  def update(user : Octobur::Model::User) : Nil
    return unless user.id?

    query = <<-SQL
    UPDATE users
    SET username=$1, email=$2, password_hash=$3, last_seen=$4
    WHERE "id"=$5;
    SQL

    user.before_save
    @database.exec(query, user.username, user.email, user.password_hash, user.last_seen, user.id)
  end

  def delete(id : Int64) : Nil
    query = <<-SQL
    DELETE FROM users WHERE id = $1;
    SQL

    @database.exec(query, id)
  end
end
