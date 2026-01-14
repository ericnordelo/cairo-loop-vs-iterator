#!/usr/bin/env python3
"""
Parse snforge test --gas-report output and create a formatted comparison
of iterator vs loop gas costs.
"""

import re
import subprocess
import sys
from collections import defaultdict
from typing import Dict, Tuple, Optional

def parse_gas_report(input_text: Optional[str] = None) -> Dict[str, Dict[str, int]]:
    """
    Parse snforge test --gas-report output.
    If input_text is provided, use it; otherwise run snforge.
    """
    if input_text is None:
        print("Running snforge test --gas-report...\n", file=sys.stderr)

        result = subprocess.run(
            ["snforge", "test", "--gas-report"],
            capture_output=True,
            text=True,
            cwd="."
        )

        if result.returncode != 0:
            print(f"Error running snforge: {result.stderr}", file=sys.stderr)
            sys.exit(1)

        input_text = result.stdout

    # Pattern to match: [PASS] test_name (l1_gas: ~X, l1_data_gas: ~Y, l2_gas: ~Z)
    pattern = r'\[PASS\]\s+([^\s]+)\s+\([^)]*l2_gas:\s+~(\d+)\)'

    tests = {}
    for line in input_text.split('\n'):
        match = re.search(pattern, line)
        if match:
            test_name = match.group(1)
            l2_gas = int(match.group(2))
            # Extract just the function name (last part after ::)
            # Test names are now like: cairo_iterators_integrationtest::test_sum::benchmark_sum_iterator_small
            func_name = test_name.split('::')[-1]
            tests[func_name] = l2_gas

    return tests

def categorize_test(test_name: str) -> Optional[Tuple[str, str, str]]:
    """
    Categorize test name into (operation, size, approach).
    Returns None if test doesn't match expected pattern.
    """
    # Pattern: benchmark_{operation}_{approach}_{size}
    # or: benchmark_{operation}_{size}_{approach}

    if not test_name.startswith('benchmark_'):
        return None

    parts = test_name.replace('benchmark_', '').split('_')

    # Find the approach (iterator or loop)
    if 'iterator' in parts:
        approach = 'iterator'
        parts.remove('iterator')
    elif 'loop' in parts:
        approach = 'loop'
        parts.remove('loop')
    else:
        return None

    # Find the size (small, medium, large)
    size = None
    for s in ['small', 'medium', 'large']:
        if s in parts:
            size = s
            parts.remove(s)
            break

    # Remaining parts should be the operation
    operation = '_'.join(parts)

    return (operation, size, approach)

def format_number(num: int) -> str:
    """Format number with thousand separators."""
    return f"{num:,}"

def calculate_savings(iterator_gas: int, loop_gas: int) -> Tuple[float, str]:
    """Calculate percentage savings and format."""
    if loop_gas == 0:
        return 0.0, "N/A"
    savings = ((loop_gas - iterator_gas) / loop_gas) * 100
    return savings, f"{savings:+.1f}%"

def main():
    # Check if input is being piped
    if not sys.stdin.isatty():
        input_text = sys.stdin.read()
        tests = parse_gas_report(input_text)
    else:
        tests = parse_gas_report()

    if not tests:
        print("No test results found!", file=sys.stderr)
        sys.exit(1)

    # Organize tests by category
    categorized = defaultdict(dict)

    for test_name, gas in tests.items():
        category = categorize_test(test_name)
        if category:
            operation, size, approach = category
            key = f"{operation}_{size}"
            categorized[key][approach] = gas

    # Print formatted comparison
    print("=" * 100)
    print("GAS COST COMPARISON: Iterator vs Traditional Loop")
    print("=" * 100)
    print()

    # Group by operation
    operations = defaultdict(dict)
    for key, values in categorized.items():
        parts = key.rsplit('_', 1)
        if len(parts) == 2:
            operation, size = parts
            operations[operation][size] = values

    # Print table for each operation
    for operation in sorted(operations.keys()):
        op_display = operation.replace('_', ' ').title()
        print(f"\n{op_display.upper()}")
        print("-" * 100)
        print(f"{'Size':<12} {'Iterator (L2 Gas)':<20} {'Loop (L2 Gas)':<20} {'Difference':<20} {'Savings':<15}")
        print("-" * 100)

        for size in ['small', 'medium', 'large']:
            if size in operations[operation]:
                values = operations[operation][size]
                iterator_gas = values.get('iterator', None)
                loop_gas = values.get('loop', None)

                if iterator_gas is not None and loop_gas is not None:
                    diff = loop_gas - iterator_gas
                    savings_pct, savings_str = calculate_savings(iterator_gas, loop_gas)
                    diff_str = f"{'+' if diff > 0 else ''}{format_number(diff)}"

                    print(f"{size.capitalize():<12} "
                          f"{format_number(iterator_gas):<20} "
                          f"{format_number(loop_gas):<20} "
                          f"{diff_str:<20} "
                          f"{savings_str:<15}")
                elif iterator_gas is not None:
                    print(f"{size.capitalize():<12} {format_number(iterator_gas):<20} {'N/A':<20} {'N/A':<20} {'N/A':<15}")
                elif loop_gas is not None:
                    print(f"{size.capitalize():<12} {'N/A':<20} {format_number(loop_gas):<20} {'N/A':<20} {'N/A':<15}")

        print()

    # Summary statistics
    print("=" * 100)
    print("SUMMARY")
    print("=" * 100)

    total_iterator = 0
    total_loop = 0
    count = 0

    for operation_data in operations.values():
        for size_data in operation_data.values():
            if 'iterator' in size_data and 'loop' in size_data:
                total_iterator += size_data['iterator']
                total_loop += size_data['loop']
                count += 1

    if count > 0:
        avg_iterator = total_iterator / count
        avg_loop = total_loop / count
        overall_savings, savings_str = calculate_savings(avg_iterator, avg_loop)

        print(f"\nAverage Gas Costs (across all {count} comparisons):")
        print(f"  Iterator: {format_number(int(avg_iterator))} L2 gas")
        print(f"  Loop:     {format_number(int(avg_loop))} L2 gas")
        print(f"  Average Savings: {savings_str}")
        print()

if __name__ == "__main__":
    main()

