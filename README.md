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

*) importing 'potentially dodgy' json file of players stats
*) logging errors into an import error table and item which was bad
*) liveview for pagination, filtering on player name
*) sorting can be toggled ascending/descending
*) csv export
*) ecto for database
*) docker and docker-compose setup for easy installation
*) integration tests for happy/unhappy path of importing json
*) typespec support (example is inside lib/test_app/football/player/rushing_statistic.ex)
*) mix task ('mix load_data' which lives inside lib/mix/tasks/load_data.ex)
*) erlang interop (:calendar and :io_lib inside lib/test_app_web/controllers/report_controller.ex)

and probably a few other things I can't remember off the top of my head

## Bugs ??

There is an annoying thing where, when you click to filter on player name, the event delegates upto the th and it toggles the sort from asc to desc or vice versa. I can fix that with a hook I am sure, but, that's starting to go outside the 5-7 hours allocated for the task.
Oh, and there is also something funky going on with phx-throttle when set to 500 and I type fast into the input field (sometimes it doesn't register things quite .. right)
