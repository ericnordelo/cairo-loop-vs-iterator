use cairo_iterators::{fold_with_iterator, fold_with_loop};
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
fn benchmark_fold_iterator_small() {
    let data = create_test_data(10);
    let result = fold_with_iterator(data, 0);
    assert(result == 55, 'Fold sum should be 55'); // 1+2+...+10 = 55
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_fold_loop_small() {
    let data = create_test_data(10);
    let result = fold_with_loop(data, 0);
    assert(result == 55, 'Fold sum should be 55');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_fold_iterator_medium() {
    let data = create_test_data(100);
    let result = fold_with_iterator(data, 0);
    assert(result == 5050, 'Fold sum should be 5050');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_fold_loop_medium() {
    let data = create_test_data(100);
    let result = fold_with_loop(data, 0);
    assert(result == 5050, 'Fold sum should be 5050');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_fold_iterator_large() {
    let data = create_test_data(1000);
    let result = fold_with_iterator(data, 0);
    let expected: felt252 = 500500;
    assert(result == expected, 'Fold sum should be 500500');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_fold_loop_large() {
    let data = create_test_data(1000);
    let result = fold_with_loop(data, 0);
    let expected: felt252 = 500500;
    assert(result == expected, 'Fold sum should be 500500');
}

#[test]
fn test_iterator_vs_loop_equivalence_fold() {
    let data = create_test_data(50);
    let iterator_result = fold_with_iterator(data, 0);

    let data2 = create_test_data(50);
    let loop_result = fold_with_loop(data2, 0);

    assert(iterator_result == loop_result, 'Results should match');
}

