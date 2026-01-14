use cairo_iterators::{find_with_iterator, find_with_loop};
use core::array::ArrayTrait;

fn create_test_data(size: u32) -> Array<felt252> {
    let mut data = ArrayTrait::new();
    let mut i = 0;
    loop {
        if i >= size {
            break;
        }
        let value: felt252 = (i + 1).into();
        data.append(value);
        i += 1;
    }
    data
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_find_iterator_small() {
    let data = create_test_data(10);
    let result = find_with_iterator(data, 5);
    match result {
        Option::Some(value) => assert(value == 5, 'Found value should be 5'),
        Option::None => assert(false, 'Should find value 5'),
    };
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_find_loop_small() {
    let data = create_test_data(10);
    let result = find_with_loop(data, 5);
    match result {
        Option::Some(value) => assert(value == 5, 'Found value should be 5'),
        Option::None => assert(false, 'Should find value 5'),
    };
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_find_iterator_medium() {
    let data = create_test_data(100);
    let result = find_with_iterator(data, 50);
    match result {
        Option::Some(value) => assert(value == 50, 'Found value should be 50'),
        Option::None => assert(false, 'Should find value 50'),
    };
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_find_loop_medium() {
    let data = create_test_data(100);
    let result = find_with_loop(data, 50);
    match result {
        Option::Some(value) => assert(value == 50, 'Found value should be 50'),
        Option::None => assert(false, 'Should find value 50'),
    };
}

#[test]
fn test_iterator_vs_loop_equivalence_find() {
    let data = create_test_data(50);
    let iterator_result = find_with_iterator(data, 25);
    let data2 = create_test_data(50);
    let loop_result = find_with_loop(data2, 25);
    // Both should find the value
    match (iterator_result, loop_result) {
        (Option::Some(v1), Option::Some(v2)) => assert(v1 == v2, 'Found values should match'),
        _ => assert(false, 'Both should find the value'),
    };
}

