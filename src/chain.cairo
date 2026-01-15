use core::array::ArrayTrait;
use core::iter::IntoIterator;

/// Sum elements from two arrays using iterator chain approach
pub fn chain_sum_with_iterator(data1: Array<felt252>, data2: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let mut iter1 = data1.into_iter();
    let mut iter2 = data2.into_iter();
    for value in iter1.chain(iter2) {
        sum += value; // No dereference needed - into_iter() yields owned values
    }
    sum
}

/// Sum elements from two arrays using traditional loop
pub fn chain_sum_with_loop(data1: Array<felt252>, data2: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let len1 = data1.len();
    let mut i = 0;
    loop {
        if i >= len1 {
            break;
        }
        sum += *data1.at(i);
        i += 1;
    }
    let len2 = data2.len();
    i = 0;
    loop {
        if i >= len2 {
            break;
        }
        sum += *data2.at(i);
        i += 1;
    }
    sum
}

