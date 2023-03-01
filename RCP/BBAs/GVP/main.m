%% This is a binary version of the Bat Algorithm 
%% Mapping Technique : Great Value Priority
%% Open The Matlab Pool For Parallel Processing ----------------------------------------------------------- 
 matlabpool open
%% --------------- Initialisation of POI Libs To Write Excel Files ----------------------------------------
% Add Java POI Libs to matlab javapath
javaaddpath('Jar/poi-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('Jar/xmlbeans-2.3.0.jar');
javaaddpath('Jar/dom4j-1.6.1.jar');
javaaddpath('Jar/stax-api-1.0.1.jar');
%% -------------------- Starting the execution of the program ---------------------------------------------
for ind=1:12
%% -------------   Initialize the parameters of the experiments -------------------------------------------
%% -------------- The number of execution ---------------------------------
global execution 
       execution = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%% -------------- Number of itterations -----------------------------------
global iter 
       iter = [1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];
%% ------ Number of individuals contained in the population --------------
global  indiv
        indiv = 175;
%% Save the dimension of the individual (it corresponds to the size of the network)
global Dimension
       Network_size = size(Instance(ind));
       Dimension = Network_size(1);
%% Number of execution 
global Nexe
       Nexe = execution(ind);
%% Instances and neighbourhood of the network
global network 
       network = Instance(ind);
global neighbourhoud
       if ind == 1 || ind == 2 || ind == 3 || ind == 13 || ind == 16 ||  ind == 17
           neighbourhoud = neighbour(4);
       end
       if ind == 4 || ind == 5 || ind == 6 || ind == 14
           neighbourhoud = neighbour(6);
       end
       if ind == 7 || ind == 8 || ind == 9 || ind == 15
           neighbourhoud = neighbour(8);
       end
       if ind == 10 || ind == 11 || ind == 12
           neighbourhoud = neighbour(10);
       end
       if ind == 18 
          neighbourhoud =   neighbour(19);
       end
       if ind == 19
          neighbourhoud =   neighbour(63);
       end
       if ind == 20 
          neighbourhoud =   neighbour(99);
       end
%% ---- Saving the type and the dimension of the network used -------------
global instance 
      if ind == 1
          instance =  'Network_1_4x4';
      end
      if ind == 2
          instance =  'Network_2_4x4';       
      end
      if ind == 3
          instance =  'Network_3_4x4';         
      end
      if ind == 4
          instance =  'Network_1_6x6';         
      end
      if ind == 5
          instance =  'Network_2_6x6';         
      end
      if ind == 6
          instance =  'Network_3_6x6';         
      end
      if ind == 7
          instance =  'Network_1_8x8';         
      end
      if ind == 8
          instance =  'Network_2_8x8';
      end
      if ind == 9
          instance =  'Network_3_8x8';          
      end
      if ind == 10
          instance =  'Network_1_10x10';         
      end
      if ind == 11
          instance =  'Network_2_10x10';          
      end      
      if ind == 12
          instance =  'Network_3_10x10';
      end
      if ind == 13
          instance =  'Network_4_4x4';         
      end
      if ind == 14
          instance =  'Network_4_6x6';          
      end      
      if ind == 15
          instance =  'Network_4_8x8';
      end
      if ind == 16
          instance =  'Network_5_4x4';
      end
      if ind == 17
          instance =  'Network_6_4x4';
      end
      if ind == 18
          instance =  'Network_19_Cells';
      end
      if ind == 19
          instance =  'Network_7x9_Cells';
      end
      if ind == 20
          instance =  'Network_9x11_Cells';
      end
%% Prameter  of the Bat algorithm  ----------------------
     % Default parameters
     A= rand(indiv,1);      % Loudness  (constant or decreasing)
     A = 1 +(2-1).*A;       % tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION page 294 292
     r =  rand(indiv,1);     % Pulse rate (constant or decreasing) %% tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION  page 294 292
     r_zero =  rand(indiv,1);     % Pulse rate (constant or decreasing) %% tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION  page 294 292
     % This frequency range determines the scalings
     Qmin=-10;                % Frequency minimum %% tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION page 294
     Qmax= 10;                % Frequency maximum %% tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION page 294
     % Initial arrays
     Q=rand(indiv,1);            % Frequency %% tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION page 294
     v=zeros(indiv,Dimension);   % Velocities %% tiré de la litérature artcile : BBA : BINARY BAT ALGORITHM FOR FEATURE SELECTION page 294
     alpha  = 0.9;                % Paremeter extracted from the article :  BCS:A BINARY CUCKOO SEARCH ALGORITHM FOR FEATURE SELECTION
     segma  = 0.9;               % Paremeter extracted from the article :  BCS:A BINARY CUCKOO SEARCH ALGORITHM FOR FEATURE SELECTION
%% variable to saved for each execution
     %%%%   Fitness of the best individual reach after the end of all the ietteration 
     global ALL_EXECUTION
            ALL_EXECUTION = [];
     %%%% Save all the execution Time per run 
     global ALL_TIME
            ALL_TIME = [];
     %%%%% save all the best fitnesses through the generations
     global ALL_FITNESSES
            ALL_FITNESSES = [];
     %%%%% save all the itterations where the fitness value where extracted
     global ALL_ITTERATIONS
            ALL_ITTERATIONS = [];
     %%%% Mean of all the fitness reached  
     global moy
            moy =0;
     %%%% Standard deviation of the fitness reached 
     global ecart 
            ecart = 0;
     %%%% to save all the information relative to the experiment 
     global vect_one 
            vect_one = [];
     global vect_two
            vect_two = [];
     %%%% to save to best individual all along the NEXE execution 
     global FITNESS_GBEST
            FITNESS_GBEST = 1000000000000000000000000000000000000; %% It is made like this to be sure that no intial fitness is higher enough to keep it
     %%%% to save the best individual all along the Nexe exveution 
     global GBEST_ALL
            GBEST_ALL = [];
%% ---------------------------------------------------------------------
for exe=1:Nexe
%% ----- Change the seed of the Mersenne Twister Random Generator ------
rng shuffle
% ----------------------------------------------------------------------
ALL_FITNESSES = [];
ALL_ITTERATIONS = [];
ti = 0;
tic
%% variable used during the calcul -------------------------------------
     %%% Vector conaiting the fitness of all individuals of the population 
     fit = [];
     %% Vector containing the best individual so far 
     gbest = [];
     %%  Contain the fitness of the global best individual
     fitness_best = 0;
     %% save the continuous coded population 
     population = [];
     %% Save the previous state of the contnious coded population 
     populationsave = [];   
     %% save the newly binary produced offsprings
     b_population_all = [];        
%% ------------ Generate the intial population ---------------------
population = GeneratePopulation(indiv,Dimension);
% ------------------------------------------------------------------
%% ------ Generate the initial binary population for the initial continuous population -------
for w=1:indiv
        %% -----------------    Aplying the Gretest value priority ----------------
        sorted_population=[];
        permuted_population = [];
        sorted_population= sort(population(w,:),'descend');
        for i=1:Dimension
            for j=1:Dimension
                if sorted_population(i) == population(w,j)
                   permuted_population = [permuted_population j];
                end
            end
        end
        b_population = [];
        for j=1:(Dimension -1)
            if permuted_population(j) > permuted_population(j+1)
               b_population(j)= 1;
            else
                 b_population(j) = 0;
            end
        end
        if permuted_population(Dimension) > permuted_population(1)
              b_population(Dimension)= 1;
        else
              b_population(Dimension) = 0;
        end
        %% ------- Add the newly produced offsprings to the population ---------------------------
        b_population_all = [b_population_all;b_population];
        % -----------------------------------------------------------------------------------------
end
%% ************** Check if the produced offsprings are feasible solutions *************************
for w=1:indiv  
    if b_population_all(w,:) ==  zeros(1,Dimension)
        b_population_all(w,randi(Dimension)) =  1;
    end
end
%% ************** Evaluate the newly produced offsprings ******************************************
parfor w=1:indiv
    result  = RC_Function(b_population_all(w,:),Dimension,network,neighbourhoud); 
    fit = [fit , result];
end
% -----------------------------------------------------------------------
%% ************** calculate the best individual (it's index , it's fitness and ..) ****************
[bestFit_one,indbest] = min(fit);
gbest = population(indbest,:);
fitness_best = min(fit);
ALL_FITNESSES = [ALL_FITNESSES fitness_best]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS indiv];
%% ---------------------------------------------------------------
for it=1:(iter - 1) % --------- itteration loop  -----------------
%% Save the fitness of the newly produced individuals ------------
fit_new = [];
%% save the newly produced offsprings ----------------------------
b_population_all = [];
%% ------- memorize the previous state of the population ---------
populationsave = population;
%% Save the previous state of the parameteres : amplitude, rate, frequency, velocity -----
v_save = v;
A_save = A;
r_save = r;
Q_save = Q;
%% ***************  The prosessing of the bat algorithm ************************
for  w=1:indiv
           % --------Generate new solutions ----------------------
               Q(w)=Qmin+(Qmax-Qmin)*rand;
               v(w,:)= v(w,:)+(population(w,:) - gbest)*Q(w);
               population(w,:) = population(w,:) + v(w,:);   
             % -------- Do local search ----------------------
		       if rand>r(w)
                  E = -1 + (1 -(-1))* rand;
				  population(w,:) = population(w,:) + (E * (mean(A)));
               end
         % -----------------------------------------------------------------
		 %% -----------------    Aplying the Gretest value priority ----------------
         sorted_population=[];
         permuted_population = [];
         sorted_population= sort(population(w,:),'descend');
         for i=1:Dimension
            for j=1:Dimension
                if sorted_population(i) == population(w,j)
                   permuted_population = [permuted_population j];
                end
            end
         end
         b_population = [];
         for j=1:(Dimension -1)
             if permuted_population(j) > permuted_population(j+1)
               b_population(j)= 1;
             else
                 b_population(j) = 0;
             end
         end
         if permuted_population(Dimension) > permuted_population(1)
              b_population(Dimension)= 1;
         else
              b_population(Dimension) = 0;
         end
        %% ------- Add the newly produced offsprings to the population ---------------------------
        b_population_all = [b_population_all;b_population];
        % -----------------------------------------------------------------------------------------
end
%% ********* Check if the produced offsprings are feasible solutions *************
for w=1:indiv  
    if b_population_all(w,:) ==  zeros(1,Dimension)
        b_population_all(w,randi(Dimension)) =  1;
    end
end
% ---------------------------------------------------------------------------
%% *************************** Evaluate the new solutions ************************************************		 
parfor w=1:indiv 
      result  = RC_Function(b_population_all(w,:),Dimension,network,neighbourhoud); 
      %% Save the fitness of the newly produced individual ---------------
       fit_new = [fit_new result];
      % ------------------------------------------------------------------
end
%% ******************* Update or not the new population and fitness vectors *******************************
for w=1:indiv     
 %% ----- If new solutions are better, update them in   the population ------
           if  (fit_new(w) > fit(w)) || (isequal(num2str(fit_new(w)),'NaN') == 1)
               population(w,:) = populationsave(w,:);
               v(w,:) = v_save(w,:);
               A(w) = A_save(w);
               r(w) = r_save(w);
               Q(w) = Q_save(w);
           else
               if (rand < A(w)) & (fit_new(w) < fit(w))
                   fit(w) = fit_new(w) ;
                   A(w) = alpha*A(w);
                   r(w) = r_zero(w) * (1 - exp(-segma * it));
               else
                   population(w,:) = populationsave(w,:);
                   v(w,:) = v_save(w,:);
                   A(w) = A_save(w);
                   r(w) = r_save(w);
                   Q(w) = Q_save(w);
               end
           end               
end 
%% ------------calculate the new best individual --------------------
[bestFit,indbest] = min(fit);
gbest = population(indbest,:);
fitness_best = fit(indbest);
ALL_FITNESSES = [ALL_FITNESSES fitness_best]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS ((it+1)*indiv)];
save GVP.mat
it
end %--------------end of the loop t=1:iter--------------------------------
if FITNESS_GBEST > fitness_best
FITNESS_GBEST = fitness_best;
GBEST_ALL = gbest;
end
ALL_EXECUTION = [ALL_EXECUTION fitness_best];
oo = toc;
ti = ti + oo ;
ALL_TIME = [ALL_TIME ti];
exe
end
%% ----  Writing the result --------------------------------------------
moy =  mean(ALL_EXECUTION);
ecart = std (ALL_EXECUTION);
datte = mat2cell(date);
timee =  num2str(sum(ALL_TIME));
timme =  mat2cell(timee);
%% ---- Writing on Excel File ---------------------------------------------------------------------------------------------
vect_one = [datte Nexe it indiv Dimension instance timme mean(ALL_TIME) std(ALL_TIME)  min(ALL_EXECUTION) max(ALL_EXECUTION) moy ecart];
headers = {'date', 'Nbr_Execution','Nbr_Fitness_Evaluations','Nbr_Individual','Dimension (cells)','Instance','Execution_Time','Mean','Std','Best','Worst','Mean','Std'};
name = strcat(instance,'.xls');
xlwrite(name,[headers;vect_one],1);
%% --- Recording the results obtained by the best individual  -------------
datee =  num2str(date);
%% -----------------    Aplying the Gretest value priority ----------------
sorted_population=[];
permuted_population = [];
sorted_population= sort(GBEST_ALL,'descend');
for i=1:Dimension
       for j=1:Dimension
             if sorted_population(i) == GBEST_ALL(j)
                   permuted_population = [permuted_population j];
             end
       end
end
b_population = [];
for j=1:(Dimension -1)
   if permuted_population(j) > permuted_population(j+1)
      b_population(j)= 1;
   else
      b_population(j) = 0;
   end
end
if permuted_population(Dimension) > permuted_population(1)
              b_population(Dimension)= 1;
else
              b_population(Dimension) = 0;
end
GBEST_ALL = b_population;
%% --- Check if the best individual is a feasible solution ----------------
if GBEST_ALL == zeros(1,Dimension)
   GBEST_ALL(randi(Dimension)) =  1; 
end
% -------------------------------------------------------------------------
result = Gbest_Show(GBEST_ALL,Dimension,network,neighbourhoud);
vect_two = [datte result(1) result(2) result(3)];
headers = {'date','Fitness','Update Location Cost','Paging Cost'};
xlwrite(name,[headers;vect_two],2);
%% ---- Recording The Reporting Cells ID ----------------------------------
%vect_two = [cell2mat(result(4))'];
%headers = {'Reporting Cell'};
%xlwrite(name,vect_two',3);
%% ---- Recording the ID of Non Reporting Cells ---------------------------
%vect_two = [cell2mat(result(5))];
%headers = {'Non Reporting Cell'};
%xlwrite(name,vect_two',4);
%% ----- Recording information about the experiments ----------------------
xlwrite(name,ALL_EXECUTION,6);
xlwrite(name,ALL_TIME,7);
xlwrite(name,transpose(ALL_FITNESSES),8);
xlwrite(name,transpose(ALL_ITTERATIONS),9);
end % ----------- end of loop of instances --------------------------------
%% ---- Close the matlabpool ----------------------------------------------
matlabpool('close');
%% I added this command because Daniel told me that if i don't add it it will ot escape and display the results of the run 
exit;

