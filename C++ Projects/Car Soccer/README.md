Omar Abdelfatah

## Design:

#### Ball:
I added velocity_ variable with its getter and setter functions. I added a max_speed_ variable that puts a ceiling on the magnitude of the ball's velocity. Made sure that the ball stays in bounds in the update function with a bunch of if-statements. Finally, I added a collision detector for the ball and any car and I made it reflect in a realistic manner.

#### Car:
I added speed_, heading_angle_, and velocity_ variables with their getter and setter functions. The velocity_ is calculated through the speed_ and headng_angle_ of the car. I also added a max_speed_ variable that puts a ceiling on the speed_ of the car. Similarly to the ball, if-statements keep the cars in the play area. I also added a variable player_num_ to differentiate between player 1 and player 2.

#### Car Soccer:
Modified special key commands so that SPACEBAR will reset everything (giving the ball a random velocity at its original start point), the ARROW keys will move player 1, and a different set of keys would move player 2 (WASD was not working for some reason so this is the current controls: +speed = ESC, -speed = TAB, left turn = LEFT_CTRL, and right turn = LEFT_ALT). 

Each UpdateSimulation call checks if the ball collided with either car and it checks if the ball entered either of the goals.

DrawUsingOpenGL now draws the boundaries, the goals (the post is thicker than the nets), the two cars, and the two boosters. Player 1 has red car and goal to protect, while player 2 has a blue car and goal to protect.

#### Additional Features:

- Added Player2
- Gave cars a "booster" to indicate the tail of the car
