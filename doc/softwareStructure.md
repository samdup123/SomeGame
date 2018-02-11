```
+---------------------------+                                                     whether or not the player event occured
|                           |       key events
|     +------------->+      |                        +-----------------------+  <-------------+---------------------------------------------+
|                    |      |    +---------------->  |                       |                |                                             |
|         Game       |      |                        |    character listener |                |  decides based on environment if a player   |
|         Loop       |      |                        |                       +--------------> |  event can actually occur                   |
|                    |      |                        |                       |                |                                             |
|     <--------------v      |                        +-----------------------+ player event   |  makes it occur if so +                     |
|                           |                                                  requests       |                       |                     |
+---------------------------+                                                                 |                       |                     |
                                                                                              +---------------------------------------------+
                                                                                                                      |
                                                                                                                      |
                                                                                                                      |
                                                                                                                      |
                                                                                                                      |
                                                                                            +----------------------------------------------+
                                                                                            |                         |                    |
                                                                                            |                         v                    |
                                                                                            |     Graphics dude                            |
                                                                                            |                                              |
                                                                                            |                                              |
                                                                                            +----------------------------------------------+
```