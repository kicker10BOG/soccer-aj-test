# A Test for JavaMOP

This a test for using a custom class with JavaMOP. 
Currently, to get it to work, I have to do the following steps:

* Go to the `src` directory via a terminal
* Run `javamop -d output -agent mop\MotorsInSync.mop`
  * This will produce a message saying it didn't work ... oh well, continue anyways
* copy the files in `src\output\` to `src\mop\`
* Using Eclipse, open `src\notmop\SoccerMotorMotion.java` and run as `AspectJ/Java Application`.
  * Working on the terminal commands to do this. 