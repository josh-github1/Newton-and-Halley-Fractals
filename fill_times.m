% Joshua Ramayrat
% Nicholas
% Zachary
%
% The purpose of this program is to find the times, t1 and t2, for the
% hemisphere to fill to half its volume and reach half its height
% respectively. 

function [timetofill] = fill_times(t, a, b) 

    %
    % This section applies the Bisection method to find time for
    % hemisphere to fill to half its height.
    %
    % The Bisection method needs a start and end time that yields
    % positive and negative values (Set a = 0 & b = 70).

    format long                                         % display higher degrees of accuracy
    if (phi_inv(VolumeFunction(a)) - 12.5) 
        * (phi_inv(VolumeFunction(b)) - 12.5) > 0      
                                                        % checks if input values are 
                                                        % in positive and negative region.
                                                        % calls phi_inv on VolumeFunction to get height and subtracts 12.5 to set that as our zero
        disp('Incorrect Input Values, try different values where b > 60') 
        else
            x1 = (a+b)/2;                               % part of Bisection Method.
            i = 1;                                      % setting iteration count to 1.
            error = abs(phi_inv(VolumeFunction(x1))
                        -12.5);                         % error verifies if evaluated volume
                                                        % is within the desired tolerance of 10^(-8).
            while error > 10^(-8)                       % repeats Bisection Method
                                                        % until error < 10^(-8)
                if (phi_inv(VolumeFunction(a))-12.5)
                    *(phi_inv(VolumeFunction(x1))-12.5) 
                    > 0)

                    a = x1;                             % The product of volume at midpoint and endpoint  
                else                                    % should be negative for the next iterate.
                    b = x1;                             % If they're negative, the next iterate is
                end                                     % between the first midpoint and the corresponding
                x1 = (a+b)/2;                           % endpoint.    
                i = i+1;                                % adds to iteration count.
                error = abs(phi_inv(VolumeFunction(x1))-12.5);
            end
            
            disp('Fill time for half height is: ')      % display fill times and
            disp(x1)                                    % iteration counts.
            disp('Number of iterations is: ')
            disp(i)
        
    end

    % This section pplies Newton's method to find time for 
    % hemisphere to fill to half its volume. Newton's method needs a 
    % reasonable start time for its iterations (Set t=10).

    error = abs(VolumeFunction(t)-16000);    % the error shows the closeness of volume at
                                             % a certain time to half the volume.
    i = 0;                                   % used to show number of iterates
    while error > 10^(-8) && i < 10000       % Repeat Newton's method using while loops
                                             % Set a limit to amount of
                                             % iterations to prevent an infinite
                                             % loop or run-off                                     
        v0 = ((-800000*t*exp(-t/80) 
            - 64000000*exp(-t/80) 
            + 64000000)/1000)-16000;   
                                             % v0 is the original volume equation              
        vprime =  10*t*exp(-t/80);           % vprime is the derivative of phi.
        t0 = t - (v0/vprime);                % formula for Newton's method 
        t = t0;                              % setting the new h-value for the next Newton iterate.
        i = i+1;                             % adding 1 to the iteration count.
    end

    disp('Fill time for half volume is: ')
    disp(t)
    disp('Number of iterations: ')
    disp(i)

end

