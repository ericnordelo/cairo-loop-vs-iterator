use core::array::ArrayTrait;

/// Map and sum elements using iterator
pub fn map_sum_with_iterator(data: Array<felt252>, multiplier: felt252) -> felt252 {
    let mut sum = 0;
    let span = data.span();
    for value in span {
        let val = *value;
        sum += val * multiplier;
    }
    sum
}

/// Map and sum elements using traditional loop
pub fn map_sum_with_loop(data: Array<felt252>, multiplier: felt252) -> felt252 {
    let mut sum = 0;
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break;
        }
        sum += *data.at(i) * multiplier;
        i += 1;
    }
    sum
}

