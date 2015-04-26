-module(day3roulette).
-export([run/0]).

roulette_loop() ->
    receive
        3 -> io:format("bang.~n"), exit({roulette, die, at, erlang:time()});
        _ -> io:format("click.~n"), roulette_loop()
end.

doctor_loop() ->
    process_flag(trap_exit, true),
    receive
        {start, Me} ->
            self() ! new,
            Supervisor = spawn(fun() -> supervisor_loop(fun doctor_loop/0) end),
            Supervisor ! {monitor, Me},
            doctor_loop();

        new ->
            io:format("Creating/monitoring process.~n"),
            register(revolver, spawn_link(fun roulette_loop/0)),
            doctor_loop();

        {'EXIT', From, Reason} ->
            io:format("Reviving process ~p which died with reason ~p.~n",
                [From, Reason]),
            self() ! new,
            doctor_loop();

        die ->
            io:format("Killing doctor~n"),
            exit({doctor, die, at, erlang:time()})
    end.

supervisor_loop(ChildFun) ->
    process_flag(trap_exit, true),
    receive
        {monitor, ChildPid} ->
            io:format("Monitoring supervisor process for ~p~n", [ChildPid]),
            link(ChildPid),
            supervisor_loop(ChildFun);

        {'EXIT', From, Reason} ->
            io:format("Reviving process ~p which died with reason ~p.~n",
                [From, Reason]),
            Child = spawn_link(ChildFun),
            Child ! {start, Child},
            register(doctor, Child)
    end.

run() ->
    Doc = spawn(fun doctor_loop/0),
    register(doctor, Doc),
    Doc ! {start, Doc},
    Doc.
