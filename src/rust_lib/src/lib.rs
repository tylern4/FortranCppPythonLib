#[no_mangle]
pub extern "C" fn rust_hello() {
    println!("Hello, from rust!");
}

#[no_mangle]
pub extern "C" fn get_float() -> f32 {
    return 0.3
}

#[no_mangle]
pub extern "C" fn get_int() -> i32 {
    return 2
}

#[no_mangle]
pub extern "C" fn add_two_point_2(x: f32) -> f32 {
    return 2.2 + x
}