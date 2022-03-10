# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

module Octobur::Storage::Queries::Postgres
  CREATE_MEMBER = <<-SQL
  INSERT INTO octobur_members (username, email, created_at, password_hash) VALUES ($1, $2, $3, $4) RETURNING id;
  SQL

  RETRIEVE_MEMBER_BY_ID = <<-SQL
  SELECT * FROM octobur_members WHERE id = $1;
  SQL

  UPDATE_MEMBER = <<-SQL
  UPDATE octobur_members SET
    username = COALESCE($2, username),
    username = COALESCE($3, email),
    username = COALESCE($4, password_hash)
    username = COALESCE($5, active)
  WHERE id = $1;
  SQL

  DELETE_MEMBER = <<-SQL
  DELETE FROM octobur_members WHERE id = $1;
  SQL
end
