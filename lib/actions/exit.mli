(** This module contains everything related to the Exit {!Lsp__Action.t} *)


(** This function allows to register a hook that is executed right before the exit notification
    is sent. It allows for example to close any channel that was needs to be close before ending *)
val register_before_exit : (unit -> unit) -> unit


(** Ends the process of the server. It should be shut down properly before *)
val exit : unit -> unit

