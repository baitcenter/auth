defmodule Auth.PersonTest do
  use Auth.DataCase
  alias Auth.{Person}

  test "create_person/1" do
    alex = %{email: "alex@gmail.com"}
    person = Person.create_person(alex)
    # IO.inspect(person, label: "person:8")
    assert person.id > 1

    # attempt to recreate alex (just returns existing record):
    person2 = Person.create_person(alex)
    assert person2.id == person.id
  end
end
