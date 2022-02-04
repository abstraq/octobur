# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena"
require "jennifer"
require "crystal-argon2"

@[ASRA::ExclusionPolicy(:all)]
class User < Jennifer::Model::Base
  include ASR::Serializable
  include AVD::Validatable

  mapping(
    id: Primary32,
    email: String,
    username: String,
    password_hash: {type: String, default: ""},
    created_at: Time,
    last_seen: Time?,
    password: {type: String?, virtual: true, setter: false}
  )

  @[ASRA::Expose]
  getter id : Int32?

  @[Assert::Email(:html5)]
  getter email : String

  @[ASRA::Expose]
  @[Assert::Size(3..25, "The username must be atleast 3 characters.", "The username can not be longer than 25 characters.")]
  @[Assert::Regex(/^\w+$/, message: "The username must only contain alphanumeric characters with the exception of underscore.")]
  getter username : String

  @[ASRA::Expose]
  getter created_at : Time

  @[ASRA::Expose]
  getter last_seen : Time?

  @[Assert::Size(8.., "The password must be atleast 8 characters.")]
  getter password : String?

  # Hash the user password using Argon2ID algorithm
  def password=(raw_password : String)
    @password = raw_password
    hasher = Argon2::Password.new
    unless raw_password.empty?
      @password_hash = hasher.create(raw_password, Argon2::Engine::EngineType::ARGON2ID)
    end
  end

  def self.table_prefix
    "opal_"
  end

  def save!
    validator = AVD.validator
    if self.is_a? AVD::Validatable
      errors = validator.validate self
      raise AVD::Exceptions::ValidationFailed.new errors unless errors.empty?
    end
    super
  end
end
