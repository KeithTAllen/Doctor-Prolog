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
symptom(bloating).     
symptom(constipation).   
symptom(dirrahea).
symptom(heartburn). 
symptom(abdominal_Pain). 
symptom(congestion).
symptom(short_Of_Breath). 
symptom(stomach_Pain). 
symptom(dark_Urine).  

%%%%%%%%%% Diseases 
%%% disease(Disease).
disease(influenza).
disease(gastrointestinal_Illnesses).
disease(legionnaires_Disease).
disease(hepatitis_A).

listOfDisease([gastrointestinal_Illnesses, influenza, legionnaires_Disease, hepatitis_A]).

%%%%%%%%%% symptom lists for diseases
%%% symptomOf(Symptom, Disease).
%%%%%%%%%%
symptomOf(cough, influenza).
symptomOf(fatigue, influenza).
symptomOf(fever, influenza).
symptomOf(aches, influenza).
symptomOf(vomiting, influenza).
symptomOf(sore_Throat, influenza).
symptomOf(congestion, influenza).

symptomOf(vomiting, gastrointestinal_Illnesses).
symptomOf(diarrhea, gastrointestinal_Illnesses).
symptomOf(bloating, gastrointestinal_Illnesses).
symptomOf(constipation, gastrointestinal_Illnesses).
symptomOf(heartburn, gastrointestinal_Illnesses).
symptomOf(abdominal_Pain, gastrointestinal_Illnesses).

symptomOf(fatigue, hepatitis_A).
symptomOf(headache, hepatitis_A).
symptomOf(fever, hepatitis_A).
symptomOf(aches, hepatitis_A). 
symptomOf(vomiting, hepatitis_A).
symptomOf(yellow_Skin, hepatitis_A).
symptomOf(dark_Urine, hepatitis_A).
symptomOf(stomach_Pain, hepatitis_A).

symptomOf(cough, legionnaires_Disease).
symptomOf(headache, legionnaires_Disease).
symptomOf(fever, legionnaires_Disease).
symptomOf(aches, legionnaires_Disease).
symptomOf(short_Of_Breath, legionnaires_Disease).

%%%%%%%%%% symptomListDisease([Symptom1, Symptom2, ... , SymptomN], disease(Disease)).
symptomListDisease([cough, fatigue, fever, aches, vomiting, sore_Throat, congestion], disease(influenza)).
symptomListDisease([vomiting, diarrhea, bloating, constipation, heartburn, abdominal_Pain], disease(gastrointestinal_Illnesses)).
symptomListDisease([cough, headache, fever, aches, short_Of_Breath], disease(legionnaires_Disease)).
symptomListDisease([fatigue, headache, fever, aches, vomiting, yellow_Skin, dark_Urine, stomach_Pain], disease(hepatitis_A)).

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

%%%%%%%%%% percentMatch(UserDiseaseList, Percent, Output) where the Output is the 
%%% disease that has the highest percent of matches that passes a threshhold
percentMatch(UserDiseaseList, Percent, BestMatch) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, UserCount),
    length(DiseaseList, UserLength),
    UserPercent is ( ( 100 * UserCount ) / UserLength ),

    %%%is count is greater than or equal to count for gastrointestinal_Illnesses
    symptomListDisease(GastroList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, GastroList , GastroCount),
    
    length(GastroList, GastroLength),
    GastroPercent is ( ( 100 * GastroCount ) / GastroLength ),
    GastroPercent =< UserPercent,
    % write("passed gastrointestinal_Illnesses"), nl,

    %%%is count is greater than or equal to count for influenza
    symptomListDisease(InfluenzaList, disease(influenza)),
    countSameElements(UserDiseaseList, InfluenzaList , InfluenzaCount),

    length(InfluenzaList, InfluenzaLength),
    InfluenzaPercent is ( ( 100 * InfluenzaCount ) / InfluenzaLength ),
    InfluenzaPercent =< UserPercent,    
    % write("passed influenza"), nl,

    %%%is count is greater than or equal to count for legionnaires_Disease
    symptomListDisease(LegionList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, LegionList, LegionCount),
    
    length(LegionList, LegionLength),
    LegionPercent is ( ( 100 * LegionCount ) / LegionLength ),
    LegionPercent =< UserPercent,    
    % write("passed legionnaires_Disease"), nl,

    %%%is count is greater than or equal to count for hepatitis_A
    symptomListDisease(HepList, disease(hepatitis_A)),
    countSameElements(UserDiseaseList, HepList, HepCount),

    length(HepList, HepLength),
    HepPercent is ( ( 100 * HepCount ) / HepLength ),
    HepPercent =< UserPercent,     
    % write("passed hepatitis_A"), nl,
 
    Percent =< UserPercent,
    % write(Percent),
    BestMatch = Disease.

%%%%%%%%%% bestMatch(UserDiseaseList, Output) where the Output is the disease that
%%% has the best percent of matches
bestMatch(UserDiseaseList, BestMatch) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, UserCount),
    length(DiseaseList, UserLength),
    UserPercent is ( ( 100 * UserCount ) / UserLength ),

    %%%is count is greater than or equal to count for gastrointestinal_Illnesses
    symptomListDisease(GastroList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, GastroList , GastroCount),
    
    length(GastroList, GastroLength),
    GastroPercent is ( ( 100 * GastroCount ) / GastroLength ),
    GastroPercent =< UserPercent,
    % write("passed gastrointestinal_Illnesses"), nl,

    %%%is count is greater than or equal to count for influenza
    symptomListDisease(InfluenzaList, disease(influenza)),
    countSameElements(UserDiseaseList, InfluenzaList , InfluenzaCount),

    length(InfluenzaList, InfluenzaLength),
    InfluenzaPercent is ( ( 100 * InfluenzaCount ) / InfluenzaLength ),
    InfluenzaPercent =< UserPercent,    
    % write("passed influenza"), nl,

    %%%is count is greater than or equal to count for legionnaires_Disease
    symptomListDisease(LegionList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, LegionList, LegionCount),
    
    length(LegionList, LegionLength),
    LegionPercent is ( ( 100 * LegionCount ) / LegionLength ),
    LegionPercent =< UserPercent,    
    % write("passed legionnaires_Disease"), nl,

    %%%is count is greater than or equal to count for hepatitis_A
    symptomListDisease(HepList, disease(hepatitis_A)),
    countSameElements(UserDiseaseList, HepList, HepCount),

    length(HepList, HepLength),
    HepPercent is ( ( 100 * HepCount ) / HepLength ),
    HepPercent =< UserPercent,     
    % write("passed hepatitis_A"), nl,
 
    BestMatch = Disease.

isEmpty(List) :- List = []. 

%----------------------------------------------------------
% Main Program
%----------------------------------------------------------

%Start here

main :- 
    getSymptoms(UserSymptomList), % Get user symptoms
    percentMatch(UserSymptomList, 70, Best), % Find best match
    write('You likely have '), write(Best), nl. % Print result

main :-
    nl, write("Hmmmm, I think I need more information."), nl,
    write("How about I ask you some questions."), nl,
    write("Do you have any other symptoms you haven't mentioned?"),
    write(UserSymptomList).


%----------------------------------------------------------
% Ask user for symptoms -
%----------------------------------------------------------
getSymptoms(UserSymptoms) :-
    write('What symptoms do you have?'), nl,
    write('Enter a symptom list followed by a period.'), nl,
    write('like this [S1,S2,S3,...].'), nl,
    read(UserSymptoms),
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