# Quick Description

**Programmers :shipit:**: Zakaria Abdelmoiz DAHI. 

**About:** This repositiory contains the implementation of the approaches in [1] that studies the solving of the binary antenna placement and the moblity management problems using a conitnuous swarm algorithm. We use instances of `149 to 5000 antennas` and `three types of antennas` (Omnidirectional, directional and Squared). Evtually, I made an option for testing a fourth strategy where all types of antennas can be used. For the reporting cell problem, the instances being used are up to 10x10 cells.

- [1] **Z.A. DAHI**, C. Mezioud, A. Draa (2015). Binary Bat Algorithm: On The Efficiency of Mapping Functions When Handling Binary Problems Using Continuous-variable-based Metaheuristics. Conférence Internationale sur l'Informatique et ses Applications. 10.1504/IJRIS.2017.10007147.

## **How :green_book:** 

- Depending on the problem you want to tackle navigate to its corresponding folder: `APP` for the antenna positioning problem or `MMP` for the mobility management problem.
- Either for the APP or the MMP, you will find two subfilders named `BBAs` and `SOTA` containing the binary variants of the bat algorithm or the one of the state-of-the-art algorithms.
- Once you have navigated to the folder of the corresponding variant, you just need to execute the file `main.m`.


## **Folders Hiearchy :open_file_folder:**
    
- `APP/MMP`: This folder contains the generational genetic algorithm.
  - `BBAs`: This folder contains the binary variants of the bat algorithm:
    - `AM`: implements the variant using the `Angle Modulation` technique.
    - `GVP`: implements the variant using the `great Value Priority` technique.
    - `Nearest Integer`: implements the variant using the rounding to `Nearest Integer` technique.
    - `Normalised`: implements the variant using the `Normalisation` technique.
    - `Sigmoid Function`: implements the variant using the `Sigmoid Function` technique.
  - `SOTA`: This folder contains the code of the state of the art algorithms:
    - `PBIL`: `Population-Based Incremental Learning`. 
    - `DE`: implements the differential evolution algorithm.

- `Results`: 
    - `Graphical`: the results will be automatically stored as `gif` figures.
    - `Nurmerical`: the results will be stored as `Excel` files with name as `instance_shape.xls`, where `instance` is the size of the benchmarks (i.e. the number of candidate Antennas) and `shape` is the shape of the antenna being using. The size ranges from 149 to 1000 candidate antennas, while for the shapes we use omnidirectional, directional and rectangular. 
        
## **Demo :movie_camera:**
    
- Please refer to the original paper [HERE](https://www.inderscience.com/info/inarticle.php?artid=86149) for more detailed results and discussions.
