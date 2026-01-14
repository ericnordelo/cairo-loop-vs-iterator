use core::array::ArrayTrait;
use core::iter::IntoIterator;

/// Sum first N elements using iterator take approach
pub fn take_sum_with_iterator(data: Array<felt252>, n: usize) -> felt252 {
    let mut sum = 0;
    let span = data.span();
    let mut iter = span.into_iter();
    for value in iter.take(n) {
        sum += *value;
    }
    sum
}

/// Sum first N elements using traditional loop
pub fn take_sum_with_loop(data: Array<felt252>, n: usize) -> felt252 {
    let mut sum = 0;
    let len = data.len();
    let limit = if n < len {
        n
    } else {
        len
    };
    let mut i = 0;
    loop {
        if i >= limit {
            break;
        }
        sum += *data.at(i);
        i += 1;
    }
    sum
}

