(** The LSP module contains the functor {!Make} that builds a language server
    from a parameter module with signature [P] *)

(** This module type defines the signature of parameters that should be given
    to the {!Make} functor in order to build a Language Server *)

module type P = sig
  val language_name : string
  (** The name of the language *)

  val language_id : string
  (** Id of the language for the protocol *)

  val inc : in_channel
  (** Channel from which the message are comming *)

  val outc : out_channel
  (** Where the protocol should answer *)

  val logc : out_channel
  (** Where the protocol should log *)

  module Hooks : Hooks.S
end

(** This module types defines the signature of a Language Server. It can only
    be started. *)
module type S = sig
  val start : unit -> int
  (** Executing start will launch the language server. It uses
      {!Lsp__Rpc.read_message} to read the the messages from {!P.inc} *)
end

(** This functor builds a Language Server from a parameter module of signature
    {!P} *)
module Make (P : P) : sig
  val start : unit -> int
  (** Executing start will launch the language server. It uses
      {!Lsp__Rpc.read_message} to read the the messages from {!P.inc} *)
end
