# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https: //opensource.org/licenses/MIT.

module Octobur::Model::Repository(T)
  abstract def insert(entity : T) : Nil

  abstract def find(id : Int64) : T?

  abstract def update(entity : T) : Nil

  abstract def delete(id : Int64) : Nil
end
