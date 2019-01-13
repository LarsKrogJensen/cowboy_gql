defmodule Gqlone.Schema do
  use Absinthe.Schema
  alias Gqlone.Resolver

  import_types Gqlone.Schema.Types

  query do

    @desc "All postssss"
    field :posts, list_of(:post) do
      resolve &Resolver.list_posts/3
    end
  end

end
