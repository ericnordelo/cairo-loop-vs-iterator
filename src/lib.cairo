pub mod all;
pub mod any;
pub mod count;
pub mod enumerate;
pub mod filter_sum;
pub mod find;
pub mod fold;
pub mod map_sum;
/// Benchmark functions comparing iterator vs traditional loop approaches
/// Functions are organized by operation type in separate modules

pub mod sum;
pub mod take;
pub mod zip;
pub use all::{all_with_iterator, all_with_loop};
pub use any::{any_with_iterator, any_with_loop};
pub use count::{count_with_iterator, count_with_loop};
pub use enumerate::{enumerate_sum_with_iterator, enumerate_sum_with_loop};
pub use filter_sum::{filter_sum_with_iterator, filter_sum_with_loop};
pub use find::{find_with_iterator, find_with_loop};
pub use fold::{fold_with_iterator, fold_with_loop};
pub use map_sum::{map_sum_with_iterator, map_sum_with_loop};
// pub mod chain; // TODO: Fix chain iterator type issues

// Re-export functions for convenience
pub use sum::{sum_with_iterator, sum_with_loop};
pub use take::{take_sum_with_iterator, take_sum_with_loop};
pub use zip::{zip_sum_with_iterator, zip_sum_with_loop};
// pub use chain::{chain_sum_with_iterator, chain_sum_with_loop};

