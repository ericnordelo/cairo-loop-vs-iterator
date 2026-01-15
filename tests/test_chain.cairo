use cairo_iterators::{chain_sum_with_iterator, chain_sum_with_loop};
use core::array::ArrayTrait;

/// Helper function to create test data arrays
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
fn benchmark_chain_sum_iterator_small() {
    let data1 = create_test_data(5);
    let data2 = create_test_data(5);
    // Chain sums all elements: (1+2+3+4+5) + (1+2+3+4+5) = 15 + 15 = 30
    let result = chain_sum_with_iterator(data1, data2);
    assert(result == 30, 'Chain sum should be 30');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_chain_sum_loop_small() {
    let data1 = create_test_data(5);
    let data2 = create_test_data(5);
    let result = chain_sum_with_loop(data1, data2);
    assert(result == 30, 'Chain sum should be 30');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_chain_sum_iterator_medium() {
    let data1 = create_test_data(100);
    let data2 = create_test_data(100);
    // Chain sums: 5050 + 5050 = 10100
    let result = chain_sum_with_iterator(data1, data2);
    assert(result == 10100, 'Chain sum should be 10100');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_chain_sum_loop_medium() {
    let data1 = create_test_data(100);
    let data2 = create_test_data(100);
    let result = chain_sum_with_loop(data1, data2);
    assert(result == 10100, 'Chain sum should be 10100');
}

#[test]
#[available_gas(l2_gas: 20000000)]
fn benchmark_chain_sum_iterator_large() {
    let data1 = create_test_data(1000);
    let data2 = create_test_data(1000);
    // Chain sums: 500500 + 500500 = 1001000
    let result = chain_sum_with_iterator(data1, data2);
    let expected: felt252 = 1001000;
    assert(result == expected, 'Chain sum should be 1001000');
}

#[test]
#[available_gas(l2_gas: 20000000)]
fn benchmark_chain_sum_loop_large() {
    let data1 = create_test_data(1000);
    let data2 = create_test_data(1000);
    let result = chain_sum_with_loop(data1, data2);
    let expected: felt252 = 1001000;
    assert(result == expected, 'Chain sum should be 1001000');
}

#[test]
fn test_iterator_vs_loop_equivalence_chain() {
    let data1 = create_test_data(50);
    let data2 = create_test_data(50);
    let iterator_result = chain_sum_with_iterator(data1, data2);

    let data3 = create_test_data(50);
    let data4 = create_test_data(50);
    let loop_result = chain_sum_with_loop(data3, data4);

    assert(iterator_result == loop_result, 'Results should match');
}

