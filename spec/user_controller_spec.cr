# Copyright 2022 abstraq <abstraq@outlook.com>
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file or at
# https: //opensource.org/licenses/MIT.

require "./spec_helper"

struct Octobur::Spec::UserControllerSpec < ATH::Spec::APITestCase
  def test_create_user : Nil
    body_valid = %[
      {
        "username": "abstraq",
        "email": "abstraq@outlook.com",
        "password": "loltestpasword"
      }
    ]
    body_invalid_username_min_length = %[
      {
        "username": "aq",
        "email": "abstraq@outlook.com",
        "password": "loltestpasword"
      }
    ]
    body_invalid_username_regex = %[
      {
        "username": "aq$29<crea",
        "email": "abstraq@outlook.com",
        "password": "loltestpasword"
      }
    ]
    body_invalid_email = %[
      {
        "username": "abstraq",
        "email": "abstraq",
        "password": "loltestpasword"
      }
    ]
    body_invalid_username_and_email = %[
      {
        "username": "aq",
        "email": "abstraq",
        "password": "loltestpasword"
      }
    ]

    self.post("/users/", body_valid).status.should eq HTTP::Status::CREATED
  end
end
