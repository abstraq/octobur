# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena-serializer"

struct CreateUserPayload
  include ASR::Serializable

  getter username : String
  getter email : String
  getter password : String
end

struct UpdateUserPayload
  include ASR::Serializable

  getter username : String?
  getter email : String?
  getter last_seen : Time?
end
