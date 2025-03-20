# Phlex Validator

This project is likely to become stricter over time, which means mostly every update will be a breaking change.

## Common-sense validation

This validator is designed to provide a common-sense validation experience for people writing HTML in Phlex. Sometimes that means being slightly stricter than the HTML specification. For example, there are some boolean attributes that also accept an empty string `""` as a _truthy_ value. The validator instead will require either `true` or `false`.

## Bypass

You can bypass validation by using String keys instead of Symbol keys.
