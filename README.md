# Running
Run with ```julia -tauto src/main.jl```.

Pass ```-tauto``` to use all threads.

Example run on my computer:
```
$ julia -tauto src/main.jl

Activating project at `~/aghproj/armstrong`
Precompiling project...
  1 dependency successfully precompiled in 0 seconds (1 already precompiled)
[ Info: Running on 24 threads
[ Info: To use all threads: julia -tauto src/main.jl
Starting armstrong
2
3
5
35452590104031691935943
7
449177399146038697307
28116440335967 <- last number prints a few seconds before end of program
Took 20.811174646 seconds <- total runtime (checking all 23 digit numbers, not knowing there are only 7)

```
