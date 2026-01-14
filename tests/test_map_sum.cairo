use cairo_iterators::{map_sum_with_iterator, map_sum_with_loop};
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

// ========== Map Sum Benchmarking Tests ==========

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_map_sum_iterator_small() {
    let mut data = ArrayTrait::new();
    data.append(1);
    data.append(2);
    data.append(3);
    data.append(4);
    data.append(5);

    // Multiply by 2, sum should be (1+2+3+4+5)*2 = 15*2 = 30
    let result = map_sum_with_iterator(data, 2);
    assert(result == 30, 'Mapped sum should be 30');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_map_sum_loop_small() {
    let mut data = ArrayTrait::new();
    data.append(1);
    data.append(2);
    data.append(3);
    data.append(4);
    data.append(5);

    // Multiply by 2, sum should be (1+2+3+4+5)*2 = 15*2 = 30
    let result = map_sum_with_loop(data, 2);
    assert(result == 30, 'Mapped sum should be 30');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_map_sum_iterator_medium() {
    let data = create_test_data(100);
    // Multiply by 3, sum should be 5050 * 3 = 15150
    let result = map_sum_with_iterator(data, 3);
    assert(result == 15150, 'Mapped sum should be 15150');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_map_sum_loop_medium() {
    let data = create_test_data(100);
    // Multiply by 3, sum should be 5050 * 3 = 15150
    let result = map_sum_with_loop(data, 3);
    assert(result == 15150, 'Mapped sum should be 15150');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_map_sum_iterator_large() {
    let data = create_test_data(1000);
    // Multiply by 5, sum should be 500500 * 5 = 2502500
    let expected: felt252 = 2502500;
    let result = map_sum_with_iterator(data, 5);
    assert(result == expected, 'Mapped sum should be 2502500');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_map_sum_loop_large() {
    let data = create_test_data(1000);
    // Multiply by 5, sum should be 500500 * 5 = 2502500
    let expected: felt252 = 2502500;
    let result = map_sum_with_loop(data, 5);
    assert(result == expected, 'Mapped sum should be 2502500');
}

// ========== Correctness Test ==========

#[test]
fn test_iterator_vs_loop_equivalence_map() {
    let data = create_test_data(50);
    let iterator_result = map_sum_with_iterator(data, 7);

    let data2 = create_test_data(50);
    let loop_result = map_sum_with_loop(data2, 7);

    assert(iterator_result == loop_result, 'Results should match');
}

