# project_test
Elixir build of a certain project

This is my response to a request for a coding example at a Company. Obviously, I have decided to keep names out of it, along with any keywords that people may search on github for it. I don't mind who sees this, but I obviously don't want others to copy the solution. No, I am not saying it's the best ever, but, I know that some people out there probably will try this.

## Installation and running this solution

Actually, it's using docker-compose, so, it *should* be as simple cloning the repo, doing a 'docker-compose up -d' and then hitting localhost:4000/mylive

## What does it look like ??

![Example Screenshot](/images/example.png)

## That's ugly as sin!!

Probably, I never said I was a designer :)

## What does this show ?

* importing 'potentially dodgy' json file of players stats
* logging errors during import into an "import error" table, along with the item which was bad
* liveview for pagination, filtering on player name
* sorting can be toggled ascending/descending
* csv export
* ecto for database
* docker and docker-compose setup for easy installation
* integration tests for happy/unhappy path of importing json
* typespec support (example is inside lib/test_app/football/player/rushing_statistic.ex)
* mix task ('mix load_data' which lives inside lib/mix/tasks/load_data.ex)
* erlang interop (:calendar and :io_lib inside lib/test_app_web/controllers/report_controller.ex)

and probably a few other things I can't remember off the top of my head.

Hysterically, I had to fix a @spec bug inside jaxon (the streaming json parser) so that it would take a Stream/Enumerable.t(), as opposed to the String.t() it was only accepting as input. It didn't stop the program from running, but dialyzer had a field day with that one. Oi.

## Bugs ??

There is an annoying thing where, when you click to filter on player name, the event delegates upto the th and it toggles the sort from asc to desc or vice versa. I can fix that with a hook I am sure, but, that's starting to go outside the 5-7 hours allocated for the task.
Oh, and there is also something funky going on with phx-throttle when set to 500 and I type fast into the input field (sometimes it doesn't register things quite .. right)

Lastly...

```elixir
phoenix@4bde65913bc1:/code/test_app$ mix test
......................

Finished in 0.2 seconds
22 tests, 0 failures

Randomized with seed 856516

phoenix@4bde65913bc1:/code/test_app$ mix dialyzer
Finding suitable PLTs
Checking PLT...
[:asn1, :compiler, :connection, :cowboy, :cowlib, :crypto, :csv, :db_connection, :decimal, :ecto, :ecto_sql, :eex, :elixir, :file_system, :gettext, :jason, :jaxon, :kernel, :logger, :mime, :mix, :parallel_stream, :phoenix, :phoenix_ecto, :phoenix_html, :phoenix_live_dashboard, :phoenix_live_reload, :phoenix_live_view, :phoenix_pubsub, :plug, :plug_cowboy, :plug_crypto, :postgrex, :public_key, :ranch, :runtime_tools, :ssl, :stdlib, :telemetry, :telemetry_metrics, :telemetry_poller]
Looking up modules in dialyxir_erlang-22.3.4.3_elixir-1.10.4_deps-dev.plt
Finding applications for dialyxir_erlang-22.3.4.3_elixir-1.10.4_deps-dev.plt
Finding modules for dialyxir_erlang-22.3.4.3_elixir-1.10.4_deps-dev.plt
Checking 1330 modules in dialyxir_erlang-22.3.4.3_elixir-1.10.4_deps-dev.plt
Adding 30 modules to dialyxir_erlang-22.3.4.3_elixir-1.10.4_deps-dev.plt
done in 0m4.99s
No :ignore_warnings opt specified in mix.exs and default does not exist.

Starting Dialyzer
[
  check_plt: false,
  init_plt: '/code/test_app/_build/dev/dialyxir_erlang-22.3.4.3_elixir-1.10.4_deps-dev.plt',
  files: ['/code/test_app/_build/dev/lib/test_app/ebin/Elixir.Mix.Tasks.LoadData.beam',
   '/code/test_app/_build/dev/lib/test_app/ebin/Elixir.TestApp.Application.beam',
   '/code/test_app/_build/dev/lib/test_app/ebin/Elixir.TestApp.Football.Player.RushingStatistic.beam',
   '/code/test_app/_build/dev/lib/test_app/ebin/Elixir.TestApp.Football.Player.beam',
   '/code/test_app/_build/dev/lib/test_app/ebin/Elixir.TestApp.ImportError.beam',
   ...],
  warnings: [:unknown]
]
Total errors: 0, Skipped: 0, Unnecessary Skips: 0
done in 0m1.66s
done (passed successfully)
```
