/// Sum elements with their indices using iterator enumerate approach
pub fn enumerate_sum_with_iterator(data: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let span = data.span();
    for (index, value) in span.into_iter().enumerate() {
        let idx: felt252 = index.into();
        let val = *value;
        sum += idx + val;
    }
    sum
}

/// Sum elements with their indices using traditional loop
pub fn enumerate_sum_with_loop(data: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break;
        }
        let idx: felt252 = i.into();
        sum += idx + *data.at(i);
        i += 1;
    }
    sum
}

