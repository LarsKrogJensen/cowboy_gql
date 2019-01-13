defmodule Gqlone.Data.Post do
  defstruct id: "", title: "", body: ""
  @type t :: %__MODULE__{id: String.t(), body: String.t(), title: String.t()}
end
