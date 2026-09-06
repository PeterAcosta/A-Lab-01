<?php

declare(strict_types=1);

class Calculator
{
    public function sum(int|float $a, int|float $b): int|float
    {
        return $a + $b;
    }
}

// Ejemplo de uso:
// $calculator = new Calculator();
// echo $calculator->sum(8, 12); // Devuelve: 20