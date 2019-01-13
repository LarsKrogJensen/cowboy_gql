defmodule Gqlone.Resolver do
  alias Gqlone.Data.Post

  @spec list_posts(any(), any(), any()) :: {:ok, [Gqlone.Data.Post.t(), ...]}
  def list_posts(_parent, _args, _resolution) do
    {:ok, [%Post{id: "1", title: "title", body: "pppp"}]}
  end
end
