use cairo_iterators::{all_with_iterator, all_with_loop};
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
fn benchmark_all_iterator_small() {
    let data = create_test_data(10);
    // Check if all elements are not equal to 99 (should be true)
    let result = all_with_iterator(data, 99);
    assert(result == true, 'All should be true');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_all_loop_small() {
    let data = create_test_data(10);
    let result = all_with_loop(data, 99);
    assert(result == true, 'All should be true');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_all_iterator_medium() {
    let data = create_test_data(100);
    // Check if all elements are not equal to 101 (should be true, since array has 1-100)
    let result = all_with_iterator(data, 101);
    assert(result == true, 'All should be true');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_all_loop_medium() {
    let data = create_test_data(100);
    // Check if all elements are not equal to 101 (should be true, since array has 1-100)
    let result = all_with_loop(data, 101);
    assert(result == true, 'All should be true');
}

#[test]
fn test_iterator_vs_loop_equivalence_all() {
    let data = create_test_data(50);
    let iterator_result = all_with_iterator(data, 99);
    let data2 = create_test_data(50);
    let loop_result = all_with_loop(data2, 99);
    assert(iterator_result == loop_result, 'Results should match');
}

