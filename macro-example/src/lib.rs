
extern crate proc_macro;

use proc_macro::TokenStream;
use quote::quote;

#[proc_macro_attribute]
pub fn my_custom_attribute(metadata: TokenStream, input: TokenStream) -> TokenStream {
    TokenStream::from(quote!(
        struct H {}
    ))
}
