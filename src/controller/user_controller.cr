# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena"

# Controller for the User resource, handles CRUD operations of users.
@[ADI::Register(public: true)]
@[ARTA::Route(path: "/users")]
class Octobur::Controller::UserController < ATH::Controller
  def initialize(@user_repository : Octobur::Model::AbstractUserRepository); end

  # Creates a new user.
  # POST /users
  #
  # Request Body
  #   username - The unique name the user should be identified by.
  #   email    - The email address associated with the user.
  #   password - The user's desired password.
  #
  # Response Status
  #   201 CREATED              - The user was successfully created.
  #   409 CONFLICT             - A user already exists with the provided username or email.
  #   422 UNPROCESSABLE ENTITY - The data provided for the new user failed validation.
  #
  # Response Body
  #   id         - The unique id of the created user.
  #   username   - The username of the created email.
  #   created_at - The time that the user was created.
  @[ARTA::Post("/")]
  @[ATHA::View(status: :created)]
  @[ATHA::ParamConverter("user", converter: ATH::RequestBodyConverter)]
  def create_user(user : Octobur::Model::User) : Octobur::Model::User
    # Create the user record performing validations before saving.
    @user_repository.insert user
    user
  end
end
