# raining-deltas

[![Build Status](https://travis-ci.org/ocramz/test-raining-deltas.png)](https://travis-ci.org/ocramz/test-raining-deltas)

Deltas are raining from the sky - what a waste it would be if they would fall to the ground. How many can you save?

 
## Rules 

A grid of X columns and Y rows, where the top-left cell is represented as x=0 and y=0, and the bottom-right as x=X-1 and y=Y-1.

The Deltas are falling from the top row (i.e. appear at y=0), one row per 'tick', until you catch them in your basket or they fall to the ground (after Y ticks). Each Delta falls straight down within their respective column x as specified in the input (as described below).

You are standing on the ground (at y=Y) with your basket. You can only move horizontally and at the rate of one column per 'tick'; left or right - or stand still.

To successfully catch a Delta x_you has to equal x_Delta in the tick that y_Delta becomes == Y.

Decide which x should be your starting position at the beginning of the game, and then determine which direction to move to only based on the information "visible" in the grid at any given time (or 'tick').

 

## Input

The first line of input contains two space-separated integers, representing X and Y respectively. (e.g. "10 10")

The second line of input contains the number of lines N to follow; each following line represents a 'tick' in the game.

The next N lines of input contain either:

  * an array of one or more space-separated integers, representing the column(s) in which new Deltas are falling at that 'tick' (x<sub>1</sub> x<sub>2</sub> .. x<sub>i</sub>, appearing at y=0)

  * or, the dash symbol "-" if no new Deltas are falling at that 'tick'.


## Input constraints:

0 < X < 2<sup>32</sup>

0 < Y < 2<sup>32</sup>

0 < N < 2<sup>32</sup>

0 <= x<sub>i</sub> < X

0 < i < X

 

## Output

Your code should output the number of Deltas you have caught in your basket at the end of the game. The game ends when the last Deltas have fallen into your basket, or to the ground. (N+Y therefore equals the total number of 'ticks' in this game.)
