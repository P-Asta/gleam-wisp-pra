import gleam/string_builder
import mist
import wisp.{type Request, type Response}
import wisp/wisp_mist

import gleam/erlang/process

pub fn main() {
  wisp.configure_logger()
  let key = wisp.random_string(64)
  let assert Ok(_) =
    wisp_mist.handler(handler, key)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  // The web server runs in new Erlang process, so put this one to sleep while
  // it works concurrently.
  process.sleep_forever()
}

pub fn handler(_req: Request) -> Response {
  wisp.html_response(string_builder.from_string("Hello, World!"), 200)
}
