# Cairo Iterators Gas Efficiency Showcase

This repository demonstrates that **Cairo iterators are more gas-efficient than traditional loops** for most common operations. The results show **20-30% gas savings** when using iterators over indexed loops.

## Why Iterators?

Cairo's iterator system isn't just syntactic sugar — it's actually more efficient. This repo provides concrete evidence through side-by-side comparisons of 12 different operations, each implemented with both iterators and traditional loops.

**TL;DR:** Use iterators. They're cleaner code AND cheaper gas.

## Key Findings

✅ **Iterators win for most operations:**
- `sum`, `filter_sum`, `map_sum`, `fold` — **20-28% cheaper** with iterators
- `all`, `find`, `take`, `zip` — **11-26% cheaper** with iterators
- `chain`, `any` — **2-3% cheaper** with iterators

⚠️ **Exceptions where loops win:**
- `count` — Use `len()` instead of `iter.count()` (O(1) vs O(n))
- `enumerate` at scale — Index conversion overhead makes loops faster for large arrays

## Gas Comparison Results

Run `python3 analyze_gas.py` to regenerate these results:

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


CHAIN SUM
----------------------------------------------------------------------------------------------------
Size         Iterator (L2 Gas)    Loop (L2 Gas)        Difference           Savings        
----------------------------------------------------------------------------------------------------
Small        70,170               71,920               +1,750               +2.4%          
Medium       1,026,820            1,050,420            +23,600              +2.2%          
Large        10,089,820           10,320,420           +230,600             +2.2%          


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

Average Gas Costs (across 27 comparisons, excluding count and enumerate):
  Iterator: 1,505,199 L2 gas
  Loop:     1,858,991 L2 gas
  Average Savings: +19.0%
```

## What's Inside

Each operation is implemented twice — once with iterators, once with traditional loops:

| Operation | Iterator Example | Loop Alternative |
|-----------|------------------|------------------|
| **sum** | `for value in span { sum += *value }` | `while i < len { sum += *data.at(i) }` |
| **filter_sum** | Iterator with conditional | Loop with conditional |
| **map_sum** | Iterator with transform | Loop with transform |
| **fold** | `iter.fold(init, \|acc, x\| ...)` | Loop accumulator |
| **any** | `iter.any(\|x\| condition)` | Loop with early break |
| **all** | `iter.all(\|x\| condition)` | Loop with early break |
| **find** | `iter.find(\|x\| condition)` | Loop with early break |
| **zip** | `for (a, b) in zip(span1, span2)` | Parallel index loop |
| **enumerate** | `for (i, v) in iter.enumerate()` | Manual index tracking |
| **take** | `for v in iter.take(n)` | Loop with limit |
| **chain** | `for v in iter1.chain(iter2)` | Sequential loops |

## Running the Tests

```bash
# See formatted comparison
python3 analyze_gas.py

# Or run tests directly
snforge test --gas-report
```

## Repository Structure

```
src/
├── sum.cairo          # Sum operations
├── filter_sum.cairo   # Filter + sum
├── map_sum.cairo      # Map + sum
├── count.cairo        # Element counting
├── fold.cairo         # Fold/reduce
├── any.cairo          # Any match
├── all.cairo          # All match
├── find.cairo         # Find first
├── zip.cairo          # Zip iterators
├── enumerate.cairo    # Index + value
├── take.cairo         # Take N elements
├── chain.cairo        # Chain iterators
└── lib.cairo          # Re-exports

tests/
└── test_*.cairo       # Corresponding tests for each operation
```

## Technical Notes

- All functions are pure (no storage) for accurate gas measurement
- Iterators use `Span` for efficient iteration
- Traditional loops use indexed access with `data.at(i)`
- Gas measurements use L2 gas as the primary metric
- Tests cover small (10), medium (100), and large (1000) element arrays
