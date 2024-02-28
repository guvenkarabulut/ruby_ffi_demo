#[no_mangle]
pub extern fn nth_prime(num: u32) -> u32 {
    let mut i     = 0;
    let mut count = 0;
    while count <= num {
        i += 1;
        if prime(i) {
            count += 1;
        }
    }
    i
}

fn prime(num: u32) -> bool {
    let mut i = 2;
    while i < num {
        if num % i == 0 {
            return false;
        }
        i += 1;
    }
    true
}

#[test]
fn five() {
    assert_eq!(11, nth_prime(5));
}

#[test]
fn one_hundred() {
    assert_eq!(541, nth_prime(100));
}

#[test]
fn five_hundred() {
    assert_eq!(3571, nth_prime(500));
}
