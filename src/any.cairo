/// Check if any element matches condition (not equal to threshold) using iterator approach
pub fn any_with_iterator(data: Array<felt252>, threshold: felt252) -> bool {
    let span = data.span();
    let mut iter = span.into_iter();
    iter.any(|x| *x != threshold)
}

/// Check if any element matches condition (not equal to threshold) using traditional loop
pub fn any_with_loop(data: Array<felt252>, threshold: felt252) -> bool {
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break false;
        }
        if *data.at(i) != threshold {
            break true;
        }
        i += 1;
    }
}

