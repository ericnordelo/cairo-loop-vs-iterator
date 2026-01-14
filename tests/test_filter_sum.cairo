use cairo_iterators::{filter_sum_with_iterator, filter_sum_with_loop};
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

// ========== Filter Sum Benchmarking Tests ==========

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_filter_sum_iterator_small() {
    let mut data = ArrayTrait::new();
    data.append(1);
    data.append(2);
    data.append(3);
    data.append(4);
    data.append(5);

    // Filter out 3, sum should be 1+2+4+5 = 12
    let result = filter_sum_with_iterator(data, 3);
    assert(result == 12, 'Filtered sum should be 12');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_filter_sum_loop_small() {
    let mut data = ArrayTrait::new();
    data.append(1);
    data.append(2);
    data.append(3);
    data.append(4);
    data.append(5);

    // Filter out 3, sum should be 1+2+4+5 = 12
    let result = filter_sum_with_loop(data, 3);
    assert(result == 12, 'Filtered sum should be 12');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_filter_sum_iterator_medium() {
    let data = create_test_data(100);
    // Filter out 50, sum should be sum(1..100) - 50 = 5050 - 50 = 5000
    let result = filter_sum_with_iterator(data, 50);
    assert(result == 5000, 'Filtered sum should be 5000');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_filter_sum_loop_medium() {
    let data = create_test_data(100);
    // Filter out 50, sum should be sum(1..100) - 50 = 5050 - 50 = 5000
    let result = filter_sum_with_loop(data, 50);
    assert(result == 5000, 'Filtered sum should be 5000');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_filter_sum_iterator_large() {
    let data = create_test_data(1000);
    // Filter out 500, sum should be sum(1..1000) - 500 = 500500 - 500 = 500000
    let expected: felt252 = 500000;
    let result = filter_sum_with_iterator(data, 500);
    assert(result == expected, 'Filtered sum should be 500000');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_filter_sum_loop_large() {
    let data = create_test_data(1000);
    // Filter out 500, sum should be sum(1..1000) - 500 = 500500 - 500 = 500000
    let expected: felt252 = 500000;
    let result = filter_sum_with_loop(data, 500);
    assert(result == expected, 'Filtered sum should be 500000');
}

// ========== Correctness Test ==========

#[test]
fn test_iterator_vs_loop_equivalence_filter() {
    let data = create_test_data(50);
    let iterator_result = filter_sum_with_iterator(data, 25);

    let data2 = create_test_data(50);
    let loop_result = filter_sum_with_loop(data2, 25);

    assert(iterator_result == loop_result, 'Results should match');
}

