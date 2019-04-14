# PharoChipDesigner
A little chip design game inspired by Engineer of the People (kohctpyktop) by Zachtronics

![PharoChipDesigner.png](graphics/PharoChipDesigner.png)

```smalltalk
Metacello new
  baseline: 'ChipDesigner';
  repository: 'github://pavel-krivanek/PharoChipDesigner/src';
  load.
```

## Controls

|  | Normal mode |
| ------ | ------ |
| LMB | metal |
| RMB | N silicon (red) |
| Shift + RMB | P silicon (yelow) |
| V | next LMB will add a via |
| X | delete mode |
| S | single step |
| R | run simulation |

|  | Delete mode |
| ------ | ------ |
| LMB | delete metal |
| Shift + LMB | delete silicon |
| X | normal mode |

![PharoChipDesigner.gif](graphics/PharoChipDesigner.gif)

![x903.png](graphics/x903.png)
