// @generated automatically by Diesel CLI.

diesel::table! {
    system_config (id) {
        id -> Unsigned<Bigint>,
        name -> Varchar,
        value -> Text,
    }
}
