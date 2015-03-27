== README

Make sure to set SECRET_KEY_BASE in the ENV. Locally this can be done by creating
a .env file containing
```
export SECRET_KEY_BASE="6de8eb3d635d62cadb7de669d2518ca0dec407790c2e59664001d22e4dda0efaf898af01b1bfc0526937322a1f26440c19307d69e75da5aa0dbec2c48b215a02"
```
The key should be obtained by running `rake secret` (Do not use the key here).
