# Cairo Iterators Benchmarking Suite

A comprehensive benchmarking framework to compare gas usage between iterator-based and traditional loop approaches in Cairo. This project provides real-world data to help developers make informed decisions about when to use iterators vs traditional loops in their smart contracts.

## The Idea

Cairo's iterator system offers powerful abstractions for working with collections, but many developers wonder: **Are iterators more gas-efficient than traditional loops?** This repository answers that question by providing:

- **Side-by-side comparisons** of iterator and loop implementations for common operations
- **Gas usage measurements** across different data sizes (small, medium, large)
- **11 different iterator operations** from Cairo's corelib (sum, filter, map, count, fold, any, all, find, zip, enumerate, take)
- **Automated analysis** that generates formatted comparison reports

## Benchmark Results

Run `python3 analyze_gas.py` to regenerate these results. Full comparison table:

```
====================================================================================================
GAS COST COMPARISON: Iterator vs Traditional Loop
====================================================================================================


ALL
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        56,600               71,170               +14,570              +20.5%         
Medium       408,500              552,670              +144,170             +26.1%         


ANY
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        41,100               42,240               +1,140               +2.7%          
Medium       251,700              252,840              +1,140               +0.5%          


COUNT
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        54,980               38,710               -16,270              -42.0%         
Medium       397,880              249,310              -148,570             -59.6%         
Large        3,826,880            2,355,310            -1,471,570           -62.5%         


ENUMERATE SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        37,330               42,630               +5,300               +12.4%         
Medium       956,220              541,280              -414,940             -76.7%         
Large        9,380,220            5,266,280            -4,113,940           -78.1%         


FILTER SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        26,860               34,590               +7,730               +22.3%         
Medium       438,380              582,550              +144,170             +24.7%         
Large        4,227,380            5,667,550            +1,440,170           +25.4%         


FIND
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        47,260               53,660               +6,400               +11.9%         
Medium       328,510              395,210              +66,700              +16.9%         


FOLD
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        54,180               67,980               +13,800              +20.3%         
Medium       388,080              531,480              +143,400             +27.0%         
Large        3,727,080            5,166,480            +1,439,400           +27.9%         


MAP SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        25,260               32,990               +7,730               +23.4%         
Medium       408,280              541,480              +133,200             +24.6%         
Large        3,927,280            5,266,480            +1,339,200           +25.4%         


SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        54,280               67,980               +13,700              +20.2%         
Medium       388,180              531,480              +143,300             +27.0%         
Large        3,727,180            5,166,480            +1,439,300           +27.9%         


TAKE SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        48,640               54,700               +6,060               +11.1%         
Medium       329,890              391,750              +61,860              +15.8%         
Large        3,142,390            3,762,250            +619,860             +16.5%         


ZIP SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        52,680               61,860               +9,180               +14.8%         
Medium       684,430              875,060              +190,630             +21.8%         
Large        6,669,430            8,579,060            +1,909,630           +22.3%         

====================================================================================================
SUMMARY
====================================================================================================

Average Gas Costs (across all 30 comparisons):
  Iterator: 1,470,235 L2 gas
  Loop:     1,574,783 L2 gas
  Average Savings: +6.6%
```

**Key Findings:**
- Most iterator operations show **20-30% gas savings** compared to traditional loops
- Operations like `sum`, `filter_sum`, `map_sum`, and `fold` consistently favor iterators
- `count` favors loops (since `len()` is O(1) vs iterator counting which is O(n))
- `enumerate` shows mixed results — efficient for small arrays but worse at scale due to index conversion overhead

## About This Repository

### Structure

Functions are organized by operation type in separate modules:

**Source Files (`src/`):**
- `sum.cairo` - Sum operations
- `filter_sum.cairo` - Filter and sum operations
- `map_sum.cairo` - Map and sum operations
- `count.cairo` - Count elements
- `fold.cairo` - Fold/accumulate operations
- `any.cairo` - Check if any element matches
- `all.cairo` - Check if all elements match
- `find.cairo` - Find first matching element
- `zip.cairo` - Pair elements from two iterators
- `enumerate.cairo` - Get index-value pairs
- `take.cairo` - Limit iteration to N elements
- `lib.cairo` - Main library file that re-exports all functions

**Test Files (`tests/`):**
- Each operation has a corresponding test file (e.g., `test_sum.cairo`, `test_filter_sum.cairo`)
- Tests include small (10 elements), medium (100 elements), and large (1000 elements) benchmarks
- Each test file includes correctness tests to verify both approaches produce identical results

### Design Principles

- **Simplicity**: Pure functions without contract boilerplate - focuses purely on computation
- **Extensibility**: Easy to add new operation types by creating new source and test files
- **Consistency**: Paired functions perform identical operations for fair comparison
- **Comprehensive**: Multiple data sizes and operation types for thorough analysis
- **Measurable**: Gas reporting works automatically - no special attributes needed

## Running Benchmarks

### Quick Start

Run the formatted analysis:
```bash
python3 analyze_gas.py
```

This automatically:
1. Runs `snforge test --gas-report`
2. Parses gas costs for all tests
3. Groups by operation type and size
4. Displays formatted comparison tables
5. Calculates percentage savings
6. Shows summary statistics

### Manual Execution

Run tests directly:
```bash
snforge test
```

View raw gas report:
```bash
snforge test --gas-report
```

Pipe to analysis script:
```bash
snforge test --gas-report | python3 analyze_gas.py
```

**Note:** The `#[available_gas]` attribute is optional and not required for gas reporting. Gas reporting works automatically with `snforge test --gas-report` regardless of attributes.

## Test Coverage

The suite includes **71 tests** covering:

- **11 operation types**: sum, filter_sum, map_sum, count, fold, any, all, find, zip, enumerate, take
- **3 data sizes**: small (10), medium (100), large (1000) elements
- **30 direct comparisons** between iterator and loop approaches
- **Correctness verification** to ensure both approaches produce identical results

## Extending the Benchmark Suite

To add new benchmark comparisons:

1. Create a new source file in `src/` (e.g., `src/new_operation.cairo`) with both iterator and loop versions
2. Add the module to `src/lib.cairo` and re-export the functions
3. Create a corresponding test file in `tests/` (e.g., `tests/test_new_operation.cairo`)
4. Follow the naming convention: `benchmark_{operation}_{approach}_{size}`
5. The `analyze_gas.py` script will automatically include the new tests in the comparison report

## Technical Notes

- Iterators use `Span` for efficient iteration (converted from `Array`)
- Traditional loops use indexed access with `data.at(i)`
- All operations are pure functions (no storage) for accurate gas measurement
- Filter operations use equality checks (values not equal to threshold)
- Gas measurements use L2 gas as the primary metric

## Contributing

This is an open-source benchmarking suite. Contributions are welcome! Areas for improvement:
- Additional iterator operations from Cairo's corelib
- More complex operation combinations
- Different data patterns and distributions
- Performance optimizations
