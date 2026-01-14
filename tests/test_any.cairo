use cairo_iterators::{any_with_iterator, any_with_loop};
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
fn benchmark_any_iterator_small() {
    let data = create_test_data(10);
    // Check if any element is not equal to 99 (should be true)
    let result = any_with_iterator(data, 99);
    assert(result == true, 'Any should be true');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_any_loop_small() {
    let data = create_test_data(10);
    let result = any_with_loop(data, 99);
    assert(result == true, 'Any should be true');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_any_iterator_medium() {
    let data = create_test_data(100);
    let result = any_with_iterator(data, 99);
    assert(result == true, 'Any should be true');
}

#[test]
#[available_gas(l2_gas: 10000000)]
fn benchmark_any_loop_medium() {
    let data = create_test_data(100);
    let result = any_with_loop(data, 99);
    assert(result == true, 'Any should be true');
}

#[test]
fn test_iterator_vs_loop_equivalence_any() {
    let data = create_test_data(50);
    let iterator_result = any_with_iterator(data, 99);
    let data2 = create_test_data(50);
    let loop_result = any_with_loop(data2, 99);
    assert(iterator_result == loop_result, 'Results should match');
}

