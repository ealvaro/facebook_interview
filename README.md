Just recently, (01/2021), I was asked by Facebook recruiter to create in 40min a very simple, quick Ruby on Rails app demonstrating knowledge of Dijktra's Shortest Path Algorithm. It actually took me a whole week to complete it, during off-work hours. These are the project specs discussed in the Technical Interview.

# Technical Interview: Ruby Test #
A twist to the Shortest Path Algorithm application 
 
### Project ###
 
Imagine a house with Open spaces and Walls. Also, imagine that we have the famous Roomba autonomous vaccum cleaner.

### Example:
Input (Matrix)

  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],

  ['O', 'O', 'O', 'O', 'O', 'O', 'O'],

  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],

  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],

  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],

  ['O', 'O', 'R', 'O', 'W', 'O', 'O'],

  ['W', 'O', 'O', 'O', 'W', 'W', 'W']


Intermediate (Path lengths from 'R')

  [7, 6, 5, 6, 100, 8, 9, 6, 5, 4, 5, 6, 7, 8, 5, 4, 3, 4, 100, 8, 9, 4, 3, 2, 3, 100, 9, 10, 3, 2, 1, 2, 100, 10, 11, 2, 1, 0, 1, 100, 11, 12, 100, 2, 1, 2, 100, 100, 100]

Output (Longest Path length and vertice coordinates)

[12, [6, 7]]
 
### Requirements ###
 
- A Matrix is given with a map of Open spaces, Walls and Roomba in it, with 'O', 'W' and 'R' respectively.
- Code should be written to find the furthest away Open space for Roomba.
- Output should be the length of the path and the coordinate in Matrix of the furthest away Open space.
 
### Assessment criteria ###
 
1. Be done in 40min. 
2. Be optimal or explain Complexity and how to improve it to become optimal.
```