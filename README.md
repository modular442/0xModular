# 0xModular

> Author: **modular442** — head honcho of Modular Content

---

Just copy `bit.lua` into your project and require it:

```lua
local bit = require('bit')
```

> [!IMPORTANT]
> Make sure your project includes this file before using any of the library functions.

---

## Performance Tests

> [!NOTE]
> These are just approximate values. You may get a slightly different result.

| Function       | Time (s) |
| -------------- | -------- |
| GetString      | 0.000005 |
| GetBit         | 0.000004 |
| Not            | 0.000002 |
| And            | 0.000004 |
| Or             | 0.000002 |
| Xor            | 0.000002 |
| ToString       | 0.000004 |
| ToBytes        | 0.000019 |
| LShift         | 0.000003 |
| RShift         | 0.000002 |
| ROR            | 0.000004 |
| ROL            | 0.000003 |
| ToHEX          | 0.000010 |
| NumberToBitset | 0.000003 |

---

## Contribution & Feedback

We welcome your suggestions and fixes!  
PRs are accepted **only if they**:

- add new useful features,  
- include documentation in LuaLS format,  
- do not break backward compatibility.

> [!NOTE]
> Please run all tests and keep consistent code style when submitting PRs.

---

## License

© 2025 modular442 (Modular Content).
All rights reserved. No unauthorized copying or redistribution.