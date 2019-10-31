defmodule Twirp.TestService do
  defmodule Req do
    use Protobuf, syntax: :proto3

    @derive Jason.Encoder
    defstruct [:msg]

    field :msg, 1, type: :string
  end

  defmodule Resp do
    use Protobuf, syntax: :proto3

    @derive Jason.Encoder
    defstruct [:msg]

    field :msg, 1, type: :string
  end

  defmodule Service do
    use Twirp.Service

    package "client.test"
    service "ClientTest"

    rpc :Echo, Req, Resp, :echo
  end

  defmodule Client do
    use Twirp.Client, service: Service
  end

  defmodule Handler do
    def echo(_conn, %Req{msg: msg}) do
      %Resp{msg: msg}
    end
  end
end
