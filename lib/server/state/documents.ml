module Manager = struct
  type t = (DocumentUri.t, Item.t) Hashtbl.t

  let current : t = Hashtbl.create 10

  let find_opt_uri = Hashtbl.find_opt current

  let find_opt_id tid = find_opt_uri tid.Identifier.uri

  let find_opt_vid vid = find_opt_uri vid.VersionedIdentifier.uri

  let open_item doc = Hashtbl.replace current doc.Item.uri doc

  let close = Hashtbl.remove current

  let close_id tid = close tid.Identifier.uri

  let perform_changes vid changes =
    let VersionedIdentifier.{ uri; version } = vid in
    match find_opt_uri uri with
    | Some doc ->
        let modified = List.fold_left Item.perform_change doc changes in
        let updated = Item.set_version modified version in
        let () = Hashtbl.replace current uri updated in
        Some updated
    | None -> None
end
