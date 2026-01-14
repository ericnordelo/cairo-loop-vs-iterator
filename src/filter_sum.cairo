use core::array::ArrayTrait;

/// Filter and sum elements using iterator (sums values not equal to threshold)
pub fn filter_sum_with_iterator(data: Array<felt252>, threshold: felt252) -> felt252 {
    let mut sum = 0;
    let span = data.span();
    for value in span {
        let val = *value;
        // Filter: only sum values that are not equal to threshold
        if val != threshold {
            sum += val;
        }
    }
    sum
}

/// Filter and sum elements using traditional loop (sums values not equal to threshold)
pub fn filter_sum_with_loop(data: Array<felt252>, threshold: felt252) -> felt252 {
    let mut sum = 0;
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break;
        }
        let value = *data.at(i);
        // Filter: only sum values that are not equal to threshold
        if value != threshold {
            sum += value;
        }
        i += 1;
    }
    sum
}

