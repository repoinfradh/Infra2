package com.digitalhouse.examples.maven.java;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.digitalhouse.examples.maven.java.Adder;

public class AdderTest {

    private Adder adder;

    @BeforeEach
    public void setUp() {
        adder = new Adder();
    }

    @Test
    public void whenAddTwoZeros_ThenSumIsZero() {
        assertEquals(0, adder.add(0, 0));
    }

    @Test
    public void whenAddFirstZeroSecondNegative_ThenSumIsEqualToSecond() {
        assertEquals(-1, adder.add(0, -1));
    }

    @Test
    public void whenAddFirstNegativeSecondZero_ThenSumIsEqualToFirst() {
        assertEquals(-1, adder.add(-1, 0));
    }

    @Test
    public void whenTwoNegatives_ThenSumIsCorrect() {
        assertEquals(-3, adder.add(-1, -2));
    }

    @Test
    public void whenAddFirstZeroSecondPositive_ThenSumIsEqualToSecond() {
        assertEquals(1, adder.add(0, 1));
    }

    @Test
    public void whenAddFirstPositiveSecondZero_ThenSumIsEqualToFirst() {
        assertEquals(1, adder.add(1, 0));
    }

    @Test
    public void whenTwoPositives_ThenSumIsCorrect() {
        assertEquals(4, adder.add(2, 2));
    }

    @Test
    public void whenAddFirstPositiveSecondNegative_ThenSumIsCorrect() {
        assertEquals(0, adder.add(1, -1));
    }

    @Test
    public void whenAddFirstNegativeSecondPositive_ThenSumIsCorrect() {
        assertEquals(0, adder.add(-1, 1));
    }
}