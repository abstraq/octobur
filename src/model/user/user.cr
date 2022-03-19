# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "crystal-argon2"
require "athena"
require "db"

# Represents a User in the application.
#
# Users are the base entity. They can have roles and permissions
# that authorize them to use different resources. The user entity
# only contains essential details about the user. Any additional
# data about the user should be stored on the UserProfile associated
# with the user.
class Octobur::Model::User
  include ASR::Serializable
  include AVD::Validatable
  include DB::Serializable

  # The unique identifier of the user.
  #
  # This property is nil for users that have not been inserted yet.
  getter! id : Int64

  # The name the user is identified by.
  #
  # The username must be at least 3 characters and at max 32 characters.
  # The username may contain alphanumeric characters, underscores, and dashes.
  @[Assert::Size(3..32, "The username must be atleast 3 characters.", "The username can not be longer than 32 characters.")]
  @[Assert::Regex(/^[a-zA-Z0-9-_]+$/, "The username must only contain alphanumeric characters with the exception of underscore and dash.")]
  property username : String

  # The email address of the user.
  @[Assert::Email(:html5)]
  property email : String

  @[Assert::Size(8..64)]
  @[ASRA::IgnoreOnSerialize]
  property password : String

  getter! password_hash : String

  getter! created_at : Time

  property last_seen : Time?

  # Is the user persisted in the database.
  def is_persisted : Bool
    !id.nil?
  end

  protected def after_create(@id : Int64, @created_at : Time) : Nil; end

  # This method will be executed before insert update operations.
  protected def before_save
    # Hash the password if one was set and update the password hash.
    if @password
      hasher = Argon2::Password.new
      @password_hash = hasher.create(@password, Argon2::Engine::EngineType::ARGON2ID)
    end
  end
end
