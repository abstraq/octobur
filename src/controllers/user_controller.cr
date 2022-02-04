# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

require "athena"

require "../models/user"
require "./payloads/user_payloads"

# Controller for the User resource, handles CRUD operations of users.
@[ARTA::Route(path: "/users")]
class UserController < ATH::Controller
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
  @[ATHA::ParamConverter("data", converter: ATH::RequestBodyConverter)]
  def create_user(data : CreateUserPayload) : User
    # Check if a user already exists with the given email.
    raise ATH::Exceptions::Conflict.new "A user with this email already exists." if User.where { lower(_email) == data.email.downcase }.exists?

    # Check if a user already exists with the given username.
    raise ATH::Exceptions::Conflict.new "A user with this username already exists." if User.where { lower(_username) == data.username.downcase }.exists?

    # Create the user record performing validations before saving.
    user = User.build({:username => data.username, :email => data.email.downcase, :created_at => Time.utc})
    user.password = data.password
    user.save!
    user
  end

  # Get a list of all users.
  # GET /users
  #
  # Query Params
  #   limit  - The maximum amount of results to return.
  #   offset - How many rows to skip before returning.
  #
  # Response Status
  #   200 OK - Got the list of users.
  @[ARTA::Get("/")]
  @[ATHA::QueryParam("limit", description: "The maximum amount of results to return.")]
  @[ATHA::QueryParam("offset", description: "How many rows to skip before returning.")]
  def get_users(limit : Int32 = 100, offset : Int32 = 0) : Array(User)
    User.all
      .limit(limit)
      .offset(offset)
      .to_a
  end

  # Get a user by their id.
  # GET /users/{id}
  #   id - The unique id of the user to find.
  #
  # Response Status
  #   200 OK                   - Found the user by their id.
  #   404 NOT FOUND            - A user with the provided id does not exist.
  #
  # Response Body
  #   id         - The unique id of the user.
  #   username   - The username of the email.
  #   created_at - The time that the user was created.
  @[ARTA::Get("/{id}")]
  def get_user(id : Int32) : User
    user = User.find id
    raise ATH::Exceptions::NotFound.new "A user with the ID '#{id}' does not exist." if user.nil?
    user
  end

  # Updates a user's data.
  # PATCH /users/{id}
  #   id - The unique id of the user to update.
  #
  # Body:
  #   username (optional)  - The new value to use as the user's username.
  #   email (optional)     - The new value to use as the user's email.
  #   last_seen (optional) - The new value to use as the user's last seen time.
  #
  # Responses:
  #   204 NO CONTENT           - The user was successfully updated.
  #   404 NOT FOUND            - A user with the provided id does not exist.
  #   422 UNPROCESSABLE ENTITY - The updated data provided for the user failed validation.
  @[ARTA::Patch("/{id}")]
  @[ATHA::ParamConverter("data", converter: ATH::RequestBodyConverter)]
  def update_user(id : Int32, data : UpdateUserPayload) : ATH::Response
    user = User.find id
    raise ATH::Exceptions::NotFound.new "A user with the ID '#{id}' does not exist." if user.nil?

    # Update the user's username if a new one is provided.
    if username = data.username
      user.username = username
    end

    # Update the user's email if a new one is provided.
    if email = data.email
      user.email = email
    end

    # Update the user's last seen time if a new one is provided.
    if last_seen = data.last_seen
      user.last_seen = last_seen
    end

    user.save!
    ATH::Response.new(status: :no_content)
  end

  # Delete a user by their id.
  # DELETE /users/{id}
  #   id - The unique id of the user to delete.
  #
  # Response Status
  #   204 NO CONTENT           - The user was deleted successfully.
  #   404 NOT FOUND            - A user with the provided id does not exist.
  @[ARTA::Delete("/{id}")]
  def delete_user(id : Int32) : ATH::Response
    user = User.find id
    raise ATH::Exceptions::NotFound.new "A user with the ID '#{id}' does not exist." if user.nil?
    user.delete
    ATH::Response.new(status: :no_content)
  end
end
