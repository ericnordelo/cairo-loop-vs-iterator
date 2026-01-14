use cairo_iterators::{take_sum_with_iterator, take_sum_with_loop};
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
fn benchmark_take_sum_iterator_small() {
    let data = create_test_data(10);
    // Take first 5: 1+2+3+4+5 = 15
    let result = take_sum_with_iterator(data, 5);
    assert(result == 15, 'Take sum should be 15');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_take_sum_loop_small() {
    let data = create_test_data(10);
    let result = take_sum_with_loop(data, 5);
    assert(result == 15, 'Take sum should be 15');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_take_sum_iterator_medium() {
    let data = create_test_data(100);
    // Take first 50: sum of 1 to 50 = 50*51/2 = 1275
    let result = take_sum_with_iterator(data, 50);
    assert(result == 1275, 'Take sum should be 1275');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_take_sum_loop_medium() {
    let data = create_test_data(100);
    let result = take_sum_with_loop(data, 50);
    assert(result == 1275, 'Take sum should be 1275');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_take_sum_iterator_large() {
    let data = create_test_data(1000);
    // Take first 500: sum of 1 to 500 = 500*501/2 = 125250
    let expected: felt252 = 125250;
    let result = take_sum_with_iterator(data, 500);
    assert(result == expected, 'Take sum should be 125250');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_take_sum_loop_large() {
    let data = create_test_data(1000);
    let expected: felt252 = 125250;
    let result = take_sum_with_loop(data, 500);
    assert(result == expected, 'Take sum should be 125250');
}

#[test]
fn test_iterator_vs_loop_equivalence_take() {
    let data = create_test_data(50);
    let iterator_result = take_sum_with_iterator(data, 25);
    let data2 = create_test_data(50);
    let loop_result = take_sum_with_loop(data2, 25);
    assert(iterator_result == loop_result, 'Results should match');
}

