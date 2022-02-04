require "jennifer/migration/base"

class CreateUsers < Jennifer::Migration::Base
  def up
    exec("CREATE TABLE opal_users (id SERIAL PRIMARY KEY, username VARCHAR(100) NOT NULL, email VARCHAR(100) NOT NULL, password_hash CHAR(98) NOT NULL, created_at TIMESTAMP NOT NULL, last_seen TIMESTAMP);")
    exec("CREATE UNIQUE INDEX opal_username_index ON opal_users(username);")
    exec("CREATE UNIQUE INDEX opal_email_index ON opal_users(email);")
  end

  def down
    exec("DROP TABLE IF EXISTS opal_users;")
  end
end
