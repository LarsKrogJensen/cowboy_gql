defmodule Gqlone.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "User of the system"
  object :post do
    field :id, :id, description: "Hello Id"
    field :title, :string
    field :body, :string
  end

end
