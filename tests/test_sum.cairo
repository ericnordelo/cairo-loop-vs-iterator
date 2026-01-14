use cairo_iterators::{sum_with_iterator, sum_with_loop};
use core::array::ArrayTrait;

/// Helper function to create test data arrays of various sizes
fn create_test_data(size: u32) -> Array<felt252> {
    let mut data = ArrayTrait::new();
    let mut i = 0;
    loop {
        if i >= size {
            break;
        }
        let value: felt252 = (i + 1).into();
        data.append(value); // Values from 1 to size
        i += 1;
    }
    data
}

// ========== Sum Benchmarking Tests ==========

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_sum_iterator_small() {
    let data = create_test_data(10);
    let result = sum_with_iterator(data);
    assert(result == 55, 'Sum should be 55'); // 1+2+...+10 = 55
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_sum_loop_small() {
    let data = create_test_data(10);
    let result = sum_with_loop(data);
    assert(result == 55, 'Sum should be 55'); // 1+2+...+10 = 55
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_sum_iterator_medium() {
    let data = create_test_data(100);
    let result = sum_with_iterator(data);
    // Sum of 1 to 100 = 100 * 101 / 2 = 5050
    assert(result == 5050, 'Sum should be 5050');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_sum_loop_medium() {
    let data = create_test_data(100);
    let result = sum_with_loop(data);
    // Sum of 1 to 100 = 100 * 101 / 2 = 5050
    assert(result == 5050, 'Sum should be 5050');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_sum_iterator_large() {
    let data = create_test_data(1000);
    let result = sum_with_iterator(data);
    // Sum of 1 to 1000 = 1000 * 1001 / 2 = 500500
    let expected: felt252 = 500500;
    assert(result == expected, 'Sum should be 500500');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_sum_loop_large() {
    let data = create_test_data(1000);
    let result = sum_with_loop(data);
    // Sum of 1 to 1000 = 1000 * 1001 / 2 = 500500
    let expected: felt252 = 500500;
    assert(result == expected, 'Sum should be 500500');
}

// ========== Correctness Test ==========

#[test]
fn test_iterator_vs_loop_equivalence_sum() {
    let data = create_test_data(50);
    let iterator_result = sum_with_iterator(data);

    let data2 = create_test_data(50);
    let loop_result = sum_with_loop(data2);

    assert(iterator_result == loop_result, 'Results should match');
}

