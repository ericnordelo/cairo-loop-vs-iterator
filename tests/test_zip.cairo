use cairo_iterators::{zip_sum_with_iterator, zip_sum_with_loop};
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
fn benchmark_zip_sum_iterator_small() {
    let data1 = create_test_data(5);
    let data2 = create_test_data(5);
    // Sum of pairs: (1+1) + (2+2) + (3+3) + (4+4) + (5+5) = 2+4+6+8+10 = 30
    let result = zip_sum_with_iterator(data1, data2);
    assert(result == 30, 'Zip sum should be 30');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_zip_sum_loop_small() {
    let data1 = create_test_data(5);
    let data2 = create_test_data(5);
    let result = zip_sum_with_loop(data1, data2);
    assert(result == 30, 'Zip sum should be 30');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_zip_sum_iterator_medium() {
    let data1 = create_test_data(100);
    let data2 = create_test_data(100);
    let result = zip_sum_with_iterator(data1, data2);
    // Each pair sums to (i+1)+(i+1) = 2*(i+1), total = 2*5050 = 10100
    assert(result == 10100, 'Zip sum should be 10100');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_zip_sum_loop_medium() {
    let data1 = create_test_data(100);
    let data2 = create_test_data(100);
    let result = zip_sum_with_loop(data1, data2);
    assert(result == 10100, 'Zip sum should be 10100');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_zip_sum_iterator_large() {
    let data1 = create_test_data(1000);
    let data2 = create_test_data(1000);
    let result = zip_sum_with_iterator(data1, data2);
    // Each pair sums to (i+1)+(i+1) = 2*(i+1), total = 2*500500 = 1001000
    let expected: felt252 = 1001000;
    assert(result == expected, 'Zip sum should be 1001000');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_zip_sum_loop_large() {
    let data1 = create_test_data(1000);
    let data2 = create_test_data(1000);
    let result = zip_sum_with_loop(data1, data2);
    let expected: felt252 = 1001000;
    assert(result == expected, 'Zip sum should be 1001000');
}

#[test]
fn test_iterator_vs_loop_equivalence_zip() {
    let data1 = create_test_data(50);
    let data2 = create_test_data(50);
    let iterator_result = zip_sum_with_iterator(data1, data2);

    let data3 = create_test_data(50);
    let data4 = create_test_data(50);
    let loop_result = zip_sum_with_loop(data3, data4);

    assert(iterator_result == loop_result, 'Results should match');
}

