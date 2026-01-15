/// Find first element matching condition using iterator approach
pub fn find_with_iterator(data: Array<felt252>, target: felt252) -> Option<felt252> {
    let mut iter = data.into_iter();
    iter.find(|x| *x == target)
}

/// Find first element matching condition using traditional loop
pub fn find_with_loop(data: Array<felt252>, target: felt252) -> Option<felt252> {
    let len = data.len();
    let mut i = 0;
    loop {
        if i >= len {
            break Option::None;
        }
        if *data.at(i) == target {
            break Option::Some(*data.at(i));
        }
        i += 1;
    }
}

