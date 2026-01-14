use core::array::ArrayTrait;
use core::iter::IntoIterator;

/// Count elements using iterator approach
pub fn count_with_iterator(data: Array<felt252>) -> usize {
    data.into_iter().count()
}

/// Count elements using traditional loop
pub fn count_with_loop(data: Array<felt252>) -> usize {
    data.len()
}

