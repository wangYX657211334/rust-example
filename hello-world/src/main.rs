///
/// test
/// # aaa
///
/// ``` rust
/// test
/// ```
#[derive(Debug)]
struct User {
    name: String,
    age: u8,
}

impl User {
    fn get_name(&self) -> String {
        self.name.to_lowercase()
    }
}

impl User {
    fn get_age(&self) -> u8 {
        self.age
    }
}

impl User {
    fn new(name: &str, age: u8) -> User {
        User {
            name: String::from(name),
            age,
        }
    }
}

fn main() {
    let user = User {
        name: String::from("名字"),
        age: 8,
    };
    let name = user.get_name();
    let age = user.get_age();
    let user2 = User::new("名字2", 16);
    println!("name: {}, age: {}", name, age);
    println!("姓名2: {:#?}", user2);
}
