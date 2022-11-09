%%%%%%%%%%
%%% Basic Rules 
%%%%%%%%%%

%%%%%%%%%% Symptoms
symptom(cough).
symptom(fatigue).
symptom(headache).
symptom(fever).
symptom(aches).
symptom(vomiting).
symptom(sore_Throat).
symptom(yellow_Skin).

%%%%%%%%%% Diseases 
%%% disease(Disease).
disease(gastrointestinal_Illnesses).
disease(influenza).
disease(legionnaires_Disease).
disease(hepatitis_A).

listOfDisease([gastrointestinal_Illnesses, influenza, legionnaires_Disease, hepatitis_A]).

%%%%%%%%%% symptom lists for diseases
%%% symptomOf(Symptom, Disease).
%symptomOf(cough, influenza).
%symptomOf(cough, legionnaires_Disease).
%symptomOf(fatigue, influenza).
%symptomOf(fatigue, hepatitis_A).
%symptomOf(headache, legionnaires_Disease).
%symptomOf(headache, hepatitis_A).
%symptomOf(fever, influenza).
%symptomOf(fever, legionnaires_Disease).
%symptomOf(fever, hepatitis_A).
%symptomOf(aches, influenza).
%symptomOf(aches, legionnaires_Disease).
%symptomOf(aches, hepatitis_A). 
%symptomOf(vomiting, influenza).
%symptomOf(vomiting, hepatitis_A).
%symptomOf(vomiting, gastrointestinal_Illnesses).
%symptomOf(diarrhea, gastrointestinal_Illnesses).
%symptomOf(sore_Throat, influenza).
%symptomOf(yellow_Skin, hepatitis_A).

%%%%%%%%%% symptomListDisease([Symptom1, Symptom2, ... , SymptomN], disease(Disease)).
symptomListDisease([cough, headache, fever, aches], disease(legionnaires_Disease)).
symptomListDisease([vomiting, diarrhea], disease(gastrointestinal_Illnesses)).
symptomListDisease([fatigue, headache, fever, aches, vomiting, yellow_Skin], disease(hepatitis_A)).
symptomListDisease([cough, fever, aches, vomiting, sore_Throat], disease(influenza)).

% Base Case---------------------------------------------
countSameElements([],[_|_],0).
countSameElements([H1|T1],[H2|T2],SetCount) :-
    count(H1,[H2|T2],Count),
    countSameElements(T1,[H2|T2],SetCount1),
    SetCount is Count + SetCount1.
% Count-------------------------------------------------
count(_,[],0). % base case
count(H,[H|T],C) :-
    count(H,T,C1),
    C is C1 + 1 , !.
count(H,[_|T],C) :-
    count(H,T,C).

compareUserDiseaseList(UserDiseaseList, DiseaseList, Count) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, Count),
    write(Disease), write(' '), write(Count), nl.

%%%%%%%%%% bestMatch(UserDiseaseList, Output) where the Output is the disease that
%%% has the highest number of matches
percentMatch(UserDiseaseList, Percent, BestMatch) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, UserCount),

    %is count is greater than or equal to count for gastrointestinal_Illnesses
    symptomListDisease(GastroList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, GastroList , GastroCount),
    GastroCount =< UserCount,
    % write("passed gastrointestinal_Illnesses"), nl,

    %is count is greater than or equal to count for influenza
    symptomListDisease(InfluenzaList, disease(influenza)),
    countSameElements(UserDiseaseList, InfluenzaList , InfluenzaCount),
    InfluenzaCount =< UserCount,
    % write("passed influenza"), nl,

    %is count is greater than or equal to count for legionnaires_Disease
    symptomListDisease(LegionList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, LegionList, LegionCount),
    LegionCount =< UserCount,
    % write("passed legionnaires_Disease"), nl,

    %is count is greater than or equal to count for hepatitis_A
    symptomListDisease(HepList, disease(hepatitis_A)),
    countSameElements(UserDiseaseList, HepList, HepCount),
    HepCount =< UserCount,     
    % write("passed hepatitis_A"), nl,

    length(DiseaseList, L),
    PercentMatch is ( ( 100 * UserCount ) / L ),
    PercentMatch >= Percent, 
    BestMatch = Disease.

isEmpty(List) :- List = []. 

%----------------------------------------------------------
% Main Program
%----------------------------------------------------------

%Start here

main :-
    getSymptoms(UserSymptomList), % Get user symptoms
    bestMatch(UserSymptomList,Best), % Find best match
    write('You likely have '), write(Best), nl. % Print result

main :-
    write("Hmmmm, I think I need more information."), nl,
    write("How about I ask you some questions?").


%----------------------------------------------------------
% Ask user for symptoms -
%----------------------------------------------------------
getSymptoms(UserSymptoms) :-
    write('What symptoms do you have?'), nl,
    write('Enter a symptom list followed by a period.'), nl,
    write('like this [S1,S2,S3,...].'), nl,
    read(UserSymptoms),
<<<<<<< Updated upstream
    write('You entered: '), write(UserSymptoms), nl.   
=======
    not(isEmpty(UserSymptoms)),
    write('You entered: '), write(UserSymptoms), nl.

/* leave this out and need to write some more mains if we want to handle 
        the empty list
getSymptoms(UserSymptoms) :- 
    write("You came here for nothing?"), nl, 
    write("C'mon tell me what's up"), nl,
    read(UserSymptoms),
    not(isEmpty(UserSymptoms)),
    write('You entered: '), write(UserSymptoms), nl.

getSymptoms(_UserSymptoms) :- 
    write("Okay get out"), break.
*/

% rewrite bestmatch arity 3 
% flesh out the 4 diseases 
% write psuedocode 

%I think we should keep best match and write a similar percentMatch rule. 
%   This percentMatch would pass and assign when it passes the threshhold,
%   bestMatch would assign the best match regardless of percent

/* Psuedo Code 

add bestMatch and percentMatch in

after we swap to second main 
    ask for more symptoms
    append those symptoms to previous list
    redo a percentMatch at a higher percent, assign, and output (Type I interupts Type II)

main #3 (we have all the symptoms)
    maybe ask which symptoms are the worst? 
    need to do the weighted type II baysian 
    A disease is assigned iff it has the highest number of "important" symptoms
        and/or (probably and)
    the lowest number of "unimportant" symptoms.

    Symptoms can be weighted either 1,2,3 or -1,0,1 I am not sure, 
        this way we are comparing these values against each other and not agaisnt
        some arbitrary theshhold. I think the more we can compare things against
        other possibilities the better.  
*/