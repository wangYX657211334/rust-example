// @generated automatically by Diesel CLI.

diesel::table! {
    system_config (id) {
        id -> Int4,
        group -> Varchar,
        name -> Varchar,
        value -> Text,
    }
}
