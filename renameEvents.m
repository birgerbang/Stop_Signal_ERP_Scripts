%Correct go trials (go signal followed by correct response,
%Incorrect go trials (go signal followed by wrong response,
%Omissions (go signal followed by no response)
%Successful stop trials (a stop signal was presented and no response was given)
%Unsuccessful stop trials (also called false alarms; a stop signal was presented,but a response was given after its presentation)
%Invalid stop trials (a stop signal was presented, but the subject had already responded)
if 1>0
    for i = 1:numel(EEG.event)
        %go_trials
        if strcmp(EEG.event(i).type,'S  1')
            if strcmp(EEG.event(i+1).type,'S 65')
                EEG.event(i).type = 'go_signal_successful';
                EEG.event(i+1).type = 'response_go_valid';
            elseif strcmp(EEG.event(i+1).type,'S 71')
                EEG.event(i).type = 'go_signal_invalid';
                EEG.event(i+1).type = 'response_go_invalid';
            else
                EEG.event(i).type = 'go_signal_omission';
            end
        end
        if strcmp(EEG.event(i).type,'S  2')
            if strcmp(EEG.event(i+1).type,'S 71')
                EEG.event(i).type = 'go_signal_successful';
                EEG.event(i+1).type = 'response_go_valid';
            elseif strcmp(EEG.event(i+1).type,'S 65')
                EEG.event(i).type = 'go_signal_invalid';
                EEG.event(i+1).type = 'response_go_invalid';
            else
                EEG.event(i).type = 'go_signal_omission';
            end
        end
        if i >= numel(EEG.event)-2
            break
        end
        %stop trials invalid
        if strcmp(EEG.event(i).type,'S  3') || strcmp(EEG.event(i).type,'S  4')
            if strcmp(EEG.event(i+1).type,'S 65') || strcmp(EEG.event(i+1).type,'S 71')
                EEG.event(i).type = 'go_stop_signal_invalid';
                EEG.event(i+1).type = 'response_stop_invalid';
                if strcmp(EEG.event(i+2).type,'S  5') || strcmp(EEG.event(i+2).type,'S  6')
                    EEG.event(i+2).type = 'stop_signal_invalid';
                else
                    disp('Trigger out of order?')
                end
            end
        end
        %stop_trials
        if strcmp(EEG.event(i).type,'S  3')
            if strcmp(EEG.event(i+1).type,'S  5')
                if strcmp(EEG.event(i+2).type,'S 65')
                    EEG.event(i).type = 'go_stop_signal_unsuccessful';
                    EEG.event(i+1).type = 'stop_signal_unsuccessful';
                    EEG.event(i+2).type = 'response_stop_unsuccessful';
                elseif strcmp(EEG.event(i+2).type,'S 71')
                    EEG.event(i).type = 'go_stop_signal_invalid';
                    EEG.event(i+1).type = 'stop_signal_invalid';
                    EEG.event(i+1).type = 'response_stop_invalid';
                else
                    EEG.event(i).type = 'go_stop_signal_successful';
                    EEG.event(i+1).type = 'stop_signal_successful';
                end
            end
        end
        if strcmp(EEG.event(i).type,'S  4')
            if strcmp(EEG.event(i+1).type,'S  6')
                if strcmp(EEG.event(i+2).type,'S 71')
                    EEG.event(i).type = 'go_stop_signal_unsuccessful';
                    EEG.event(i+1).type = 'stop_signal_unsuccessful';
                    EEG.event(i+2).type = 'response_stop_unsuccessful';
                elseif strcmp(EEG.event(i+2).type,'S 65')
                    EEG.event(i).type = 'go_stop_signal_invalid';
                    EEG.event(i+1).type = 'stop_signal_invalid';
                    EEG.event(i+1).type = 'response_stop_invalid';
                else
                    EEG.event(i).type = 'go_stop_signal_successful';
                    EEG.event(i+1).type = 'stop_signal_successful';
                end
            end
        end
    end
end
        %go_signal_successful = go signal before successful go trial
        %go_signal_invalid = go signal before go trial with wrong response
        %go_signal_omission = go signal without any response
        %stop_signal_successful = stop signal with no response
        %stop_signal_unsuccessful = stop signal with response
        %stop_signal_invalid = stop signal with response before reveal or
        %wrong button
        %go_stop_signal_unsuccessful = go signal before unsuccessful stop
        %go_stop_signal_successful = go signal before successful stop
        %response_go_valid = valid response to go trial
        %response_go_invalid = invalid response to go trial (wrong button)
        %response_stop_invalid = response with wrong button or before stop
        %signal in unsuccesful stop
        %response_stop_unsuccessful = response in unsuccessful stop correct
        %button
     