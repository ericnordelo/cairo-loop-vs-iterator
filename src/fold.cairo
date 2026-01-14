use core::array::ArrayTrait;
use core::iter::IntoIterator;

/// Fold (accumulate) elements using iterator approach
pub fn fold_with_iterator(data: Array<felt252>, initial: felt252) -> felt252 {
    let span = data.span();
    let mut iter = span.into_iter();
    iter.fold(initial, |acc, x| acc + *x)
}

/// Fold (accumulate) elements using traditional loop
pub fn fold_with_loop(data: Array<felt252>, initial: felt252) -> felt252 {
    let mut result = initial;
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break;
        }
        result += *data.at(i);
        i += 1;
    }
    result
}

