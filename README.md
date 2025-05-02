# Receipt Generator

This application calculates sales tax and generates receipts for items based on the following rules:

- Basic sales tax is 10% on all goods except books, food, and medical products
- Import duty is an additional 5% tax on all imported goods
- All tax amounts are rounded up to the nearest 0.05

## Assumptions

- Input files are well-formatted and follow the expected pattern
- Item names do not contain the word "at"
- All prices are positive numbers
- Quantities are positive integers

## Installation

1. Clone the repository:

```bash
git clone https://github.com/KirbyMcKenzie/subscribe_receipt_generator.git
cd subscribe_receipt_generator
```

2. Install dependencies:

```bash
bundle install
```

## Usage

Run the application with an input file:

```bash
ruby bin/receipt_generator.rb data/input_1.txt
```

The application will output the receipt to the console.

## Input Format

The input file should contain one item per line in the following format:

```
<quantity> <item name> at <price>
```

Example:

```
2 book at 12.49
1 music CD at 14.99
```

## Testing

Run the test suite:

```bash
bundle exec rspec
```

## Further Improvements

### Error Handling

Improve application resilience and debuggability by:

- Using `begin/rescue` blocks to recover gracefully from unexpected errors without crashing the application
- Define custom exception classes (e.g., `InvalidInputError`) to express domain-specific failure modes
- Adding structured logging using Ruby's standard `Logger` class for consistent and readable error logs

### Data Validation

Make sure the input is clean and correct by:

- Ensuring values are of the correct type using `Integer()` and `Float()`, or validating format with regular expressions.
- Ensuring prices are numbers and not negative
- Making sure quantities are whole numbers greater than zero
- Validating item names (e.g., not empty, no weird characters)

### Financial Calculations

Make pricing and tax calculations accurate by:

- Using `BigDecimal` for precise decimal calculations
- Extracting tax logic into a dedicated class to improve code organization and make it easier to support additional tax rules or jurisdictions in the future
