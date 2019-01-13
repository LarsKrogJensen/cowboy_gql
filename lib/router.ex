defmodule PlugEx.Router do
  use Plug.Router

  # plug(Plug.RequestId)
  plug(Plug.Logger, log: :info)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  forward("/api",
    to: Absinthe.Plug,
    init_opts: [schema: Gqlone.Schema, json_codec: Jason]
  )

  forward("/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [schema: Gqlone.Schema, interface: :advanced, json_codec: Jason]
  )

  match(_, do: send_resp(conn, 404, "Not found"))
end
