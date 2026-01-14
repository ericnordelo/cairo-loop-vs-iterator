use cairo_iterators::{enumerate_sum_with_iterator, enumerate_sum_with_loop};
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
fn benchmark_enumerate_sum_iterator_small() {
    let data = create_test_data(5);
    // Sum of (index + value): (0+1) + (1+2) + (2+3) + (3+4) + (4+5) = 1+3+5+7+9 = 25
    let result = enumerate_sum_with_iterator(data);
    assert(result == 25, 'Enumerate sum should be 25');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_enumerate_sum_loop_small() {
    let data = create_test_data(5);
    let result = enumerate_sum_with_loop(data);
    assert(result == 25, 'Enumerate sum should be 25');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_enumerate_sum_iterator_medium() {
    let data = create_test_data(100);
    let result = enumerate_sum_with_iterator(data);
    let data2 = create_test_data(100);
    let loop_result = enumerate_sum_with_loop(data2);
    assert(result == loop_result, 'Results should match');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_enumerate_sum_loop_medium() {
    let data = create_test_data(100);
    let result = enumerate_sum_with_loop(data);
    // This is just to have a matching test, actual value verified by equivalence
    assert(result != 0, 'Result should be non-zero');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_enumerate_sum_iterator_large() {
    let data = create_test_data(1000);
    let result = enumerate_sum_with_iterator(data);
    let data2 = create_test_data(1000);
    let loop_result = enumerate_sum_with_loop(data2);
    assert(result == loop_result, 'Results should match');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_enumerate_sum_loop_large() {
    let data = create_test_data(1000);
    let result = enumerate_sum_with_loop(data);
    assert(result != 0, 'Result should be non-zero');
}

#[test]
fn test_iterator_vs_loop_equivalence_enumerate() {
    let data = create_test_data(50);
    let iterator_result = enumerate_sum_with_iterator(data);
    let data2 = create_test_data(50);
    let loop_result = enumerate_sum_with_loop(data2);
    assert(iterator_result == loop_result, 'Results should match');
}

