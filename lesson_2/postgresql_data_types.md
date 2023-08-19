# Data types in PostgreSQL

- `varchar(length)`
  - up to length characters of text
- `text`
  - unlimited length of text
- `integer`
  - whole numbers: `42`, `-3210`
- `real`
  - floating point numbers: `25.321`, `-1143.98132`
- `decimal(precision, scale)` alias `numeric`
  - arbitrary precision numbers
    - precision is max total number of digits
    - scale is max numbers to right of decimal
      - `decimal(5, 2)`... `32.12`
- `timestamp`
  - date and time: `1999-01-08 05:15:29`
- `date`
  - only date: `1990-01-08`
- `boolean`
  - `true` or `false`



#
#

## `NULL`

Absence of value 

When a `NULL` value appears to either side of any ordinary comparison operator (such as =, <, >=, etc.), the operator will return `NULL` instead of true or false


**When dealing with `NULL` values, always use the `IS NULL` or `IS NOT NULL` constructs**


#
#


## Practice Problems

1. Describe the difference between the `varchar` and `text` data types.

`varchar` takes one argument `length` which defines the maximum number of characters that can be included in the input. 
`text` does not take any arguments, and can be any number of characters. 

#

2. Describe the difference between the `integer`, `decimal`, and `real` data types.

`integer` data types are whole numbers without decimals.. `12`, `-31`, `5632`

`decimal` data types take two arguments `precision, scale` that define the max number of digits that may exist in the value and the max number of digits that can occur after the decimal point. 

`real` floating point numbers that can include fractional values. rounding errors possible

#

3. What is the largest value that can be stored in an integer column?

2147483647

#

4. Difference between `timestamp` and `date`

`timestamp` includes the data in format `YYYY:MM:DD HH:MM:SS` whereas date only includes date.

#

5. Can time with time zone be stored in a column of type `timestamp`?

No. But there is a `timestamp with time zone` (or `timestamptz`) data type that will store a timestamp with a timezone.


##

##