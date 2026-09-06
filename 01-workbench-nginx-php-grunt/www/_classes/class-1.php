<?php /*! test.local - 06-09-2026 */

declare(strict_types=1);
class Calculator
{
public function sum(int|float $a, int|float $b): int|float
{
return $a + $b;
}
}