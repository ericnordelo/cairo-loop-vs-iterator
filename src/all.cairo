use core::array::ArrayTrait;
use core::iter::IntoIterator;

/// Check if all elements match condition (not equal to threshold) using iterator approach
pub fn all_with_iterator(data: Array<felt252>, threshold: felt252) -> bool {
    let span = data.span();
    let mut iter = span.into_iter();
    iter.all(|x| *x != threshold)
}

/// Check if all elements match condition (not equal to threshold) using traditional loop
pub fn all_with_loop(data: Array<felt252>, threshold: felt252) -> bool {
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break true;
        }
        if *data.at(i) == threshold {
            break false;
        }
        i += 1;
    }
}

