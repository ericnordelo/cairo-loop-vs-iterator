use cairo_iterators::{count_with_iterator, count_with_loop};
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
        data.append(value);
        i += 1;
    }
    data
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_count_iterator_small() {
    let data = create_test_data(10);
    let result = count_with_iterator(data);
    assert(result == 10, 'Count should be 10');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_count_loop_small() {
    let data = create_test_data(10);
    let result = count_with_loop(data);
    assert(result == 10, 'Count should be 10');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_count_iterator_medium() {
    let data = create_test_data(100);
    let result = count_with_iterator(data);
    assert(result == 100, 'Count should be 100');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_count_loop_medium() {
    let data = create_test_data(100);
    let result = count_with_loop(data);
    assert(result == 100, 'Count should be 100');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_count_iterator_large() {
    let data = create_test_data(1000);
    let result = count_with_iterator(data);
    assert(result == 1000, 'Count should be 1000');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_count_loop_large() {
    let data = create_test_data(1000);
    let result = count_with_loop(data);
    assert(result == 1000, 'Count should be 1000');
}

#[test]
fn test_iterator_vs_loop_equivalence_count() {
    let data = create_test_data(50);
    let iterator_result = count_with_iterator(data);

    let data2 = create_test_data(50);
    let loop_result = count_with_loop(data2);

    assert(iterator_result == loop_result, 'Results should match');
}

