use core::array::ArrayTrait;
use core::iter::zip;

/// Sum paired elements from two arrays using iterator zip approach
pub fn zip_sum_with_iterator(data1: Array<felt252>, data2: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let span1 = data1.span();
    let span2 = data2.span();
    for (val1, val2) in zip(span1, span2) {
        sum += *val1 + *val2;
    }
    sum
}

/// Sum paired elements from two arrays using traditional loop
pub fn zip_sum_with_loop(data1: Array<felt252>, data2: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let len1 = data1.len();
    let len2 = data2.len();
    let min_len = if len1 < len2 {
        len1
    } else {
        len2
    };
    let mut i = 0;
    loop {
        if i >= min_len {
            break;
        }
        sum += *data1.at(i) + *data2.at(i);
        i += 1;
    }
    sum
}

