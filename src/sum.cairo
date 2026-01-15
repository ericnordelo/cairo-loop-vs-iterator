/// Sum elements using iterator approach
pub fn sum_with_iterator(data: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let span = data.span();
    for value in span {
        sum += *value;
    }
    sum
}

/// Sum elements using traditional loop
pub fn sum_with_loop(data: Array<felt252>) -> felt252 {
    let mut sum = 0;
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break;
        }
        sum += *data.at(i);
        i += 1;
    }
    sum
}

