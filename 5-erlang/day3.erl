-module(day3).
-export([run/0, translate/1]).

translate_loop() ->
    receive
        {From, "casa"} ->
            From ! "house",
            translate_loop();

        {From, "blanca"} ->
            From ! "white",
            translate_loop();

        {From, "mata"} ->
            From ! "Exiting",
            exit({kill,signal,received});

        {From, _} ->
            From ! "I don't understand",
            translate_loop()
    end.

translate(Word) ->
    translation_process ! {self(), Word},
    receive
        Translation -> Translation
    end.

translate_monitor() ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating/monitoring translation process.~n"),
            register(translation_process, spawn_link(fun translate_loop/0)),
            translate_monitor();

        {'EXIT', From, Reason} ->
            io:format("Reviving translation process ~p which died with reason ~p.~n",
                [From, Reason]),
            self() ! new,
            translate_monitor()
    end.

run() ->
    TranslateMonitor = spawn(fun translate_monitor/0),
    TranslateMonitor ! new.

% day3:translate("casa").
% day3:translate("blanca").
% day3:translate("mata").
% day3:translate("casa").
