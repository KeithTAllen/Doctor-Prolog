%------------------------------------------------------------------------------------------------------
% Dr.Prolog 1.0.1
% CSC 366 - Computational Models of Cognitive Processes
% Group Project:
%      Christopher Stickle
%      Keith Allen
%      Timothy Germakovsky
%------------------------------------------------------------------------------------------------------
% Facts
%------------------------------------------------------------------------------------------------------
% Symptoms
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
%------------------------------------------------------------------------------------------------------
% disease(Disease).
disease(influenza).
disease(gastrointestinal_Illnesses).
disease(legionnaires_Disease).
disease(hepatitis_A).
%------------------------------------------------------------------------------------------------------
listOfDisease([gastrointestinal_Illnesses, influenza, legionnaires_Disease, hepatitis_A]).
%------------------------------------------------------------------------------------------------------
% symptom lists for diseases
% symptomOf(Symptom, Disease, Importance).
% *importance is assigned from 1,2,3 and relates to the percent of
%   patients who have the disease and experience a given symptom
symptomOf(cough, influenza, 3).
symptomOf(fatigue, influenza, 2).
symptomOf(fever, influenza, 2).
symptomOf(aches, influenza, 2).
symptomOf(vomiting, influenza, 1).
symptomOf(sore_Throat, influenza, 3).
symptomOf(congestion, influenza, 3).

symptomOf(vomiting, gastrointestinal_Illnesses, 1).
symptomOf(diarrhea, gastrointestinal_Illnesses, 3).
symptomOf(bloating, gastrointestinal_Illnesses, 2).
symptomOf(constipation, gastrointestinal_Illnesses, 3).
symptomOf(heartburn, gastrointestinal_Illnesses, 1).
symptomOf(abdominal_Pain, gastrointestinal_Illnesses, 3).

symptomOf(fatigue, hepatitis_A, 2).
symptomOf(headache, hepatitis_A, 2).
symptomOf(fever, hepatitis_A, 2).
symptomOf(aches, hepatitis_A, 2).
symptomOf(vomiting, hepatitis_A, 2).
symptomOf(yellow_Skin, hepatitis_A, 1).
symptomOf(dark_Urine, hepatitis_A, 2).
symptomOf(stomach_Pain, hepatitis_A, 2).

symptomOf(cough, legionnaires_Disease, 2).
symptomOf(headache, legionnaires_Disease, 1).
symptomOf(fever, legionnaires_Disease, 3).
symptomOf(aches, legionnaires_Disease, 1).
symptomOf(short_Of_Breath, legionnaires_Disease, 2).
symptomOf(diarrhea, legionnaires_Disease, 2).
symptomOf(nausea, legionnaires_Disease, 2).

%------------------------------------------------------------------------------------------------------
% symptomListDisease([Symptom1, Symptom2, ... , SymptomN], disease(Disease)).
symptomListDisease([cough, fatigue, fever, aches, vomiting, sore_Throat, congestion], disease(influenza)).
symptomListDisease([vomiting, diarrhea, bloating, constipation, heartburn, abdominal_Pain], disease(gastrointestinal_Illnesses)).
symptomListDisease([fatigue, headache, fever, aches, vomiting, yellow_Skin, dark_Urine, stomach_Pain], disease(hepatitis_A)).
symptomListDisease([cough, headache, fever, aches, short_Of_Breath, nausea, diarrhea], disease(legionnaires_Disease)).
%------------------------------------------------------------------------------------------------------
% Helper functions
%------------------------------------------------------------------------------------------------------
% countSameElements(List1, List2, Count). will count the number of elements in List1 that are also in List2.
% Base Case
countSameElements([],[_|_],0).
countSameElements([H1|T1],[H2|T2],SetCount) :-
    count(H1,[H2|T2],Count),
    countSameElements(T1,[H2|T2],SetCount1),
    SetCount is Count + SetCount1.
% Count(E,List,Count) will count the number of times E appears in List.
count(_,[],0). % base case
count(H,[H|T],C) :-
    count(H,T,C1),
    C is C1 + 1 , !.
count(H,[_|T],C) :-
    count(H,T,C).

%sumWeights(List, Disease, Count) sums the weight of the symptoms in List for a single Disease.
sumWeights([], _, 0).
sumWeights([H|T], Disease, Count) :-
    %write('entered getListTotal'), nl,
    sumWeights(T, Disease, NewCount),
    symptomOf(H, Disease, Weight),
    Count is NewCount + Weight, !.
    %write('set count: '), write(Count), nl.
sumWeights(_,_,Count):-
    Count is 0.

% subtractList(ListA, ListB, ListC) will calculate ListB - ListA and unify the result to ListC.
subtractList([], ListB, ListB).
subtractList([H|T], ListB, ListC) :-
    subtractList(T, ListB, ListC1),
    delete(ListC1, H, ListC).

% assigns total weight from UserSymptomList, Disease,
getTotalWeight(UserSymptomList, Disease, TotalWeight) :-
    sumWeights(UserSymptomList, Disease , PresentWeight), % find summed weight of present symptoms
    symptomListDisease(FullDiseaseList, disease(Disease)), % grab full disease list for given disease(Disease)
    subtractList(UserSymptomList, FullDiseaseList, MissingSymptoms), % find list of symptoms the patient is not experiencing for given disease
    sumWeights(MissingSymptoms, Disease, MissingWeight), % find summed weight of missing symptoms
    TotalWeight is PresentWeight - MissingWeight. % caclulate and assign total weight

% checks if a list is empty
isEmpty(List) :- List = [].
% looks for a "No."
isNo(Input) :- Input = "No.".

%------------------------------------------------------------------------------------------------------
compareUserDiseaseList(UserDiseaseList, DiseaseList, Count) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, Count),
    write(Disease), write(' '), write(Count), nl.
%------------------------------------------------------------------------------------------------------
% percentMatch(UserDiseaseList, Percent, Output). Unifys Output to the
%   disease that has the highest percent of matches that passes a threshhold
percentMatch(UserDiseaseList, Percent, BestMatch) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, UserCount),
    length(DiseaseList, UserLength),
    UserPercent is ( ( 100 * UserCount ) / UserLength ),

    %--- is count is greater than or equal to count for gastrointestinal_Illnesses
    symptomListDisease(GastroList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, GastroList , GastroCount),
    
    length(GastroList, GastroLength),
    GastroPercent is ( ( 100 * GastroCount ) / GastroLength ),
    GastroPercent =< UserPercent,
    % write("passed gastrointestinal_Illnesses"), nl,

    %--- is count is greater than or equal to count for influenza
    symptomListDisease(InfluenzaList, disease(influenza)),
    countSameElements(UserDiseaseList, InfluenzaList , InfluenzaCount),

    length(InfluenzaList, InfluenzaLength),
    InfluenzaPercent is ( ( 100 * InfluenzaCount ) / InfluenzaLength ),
    InfluenzaPercent =< UserPercent,    
    % write("passed influenza"), nl,

    %--- is count is greater than or equal to count for legionnaires_Disease
    symptomListDisease(LegionList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, LegionList, LegionCount),
    
    length(LegionList, LegionLength),
    LegionPercent is ( ( 100 * LegionCount ) / LegionLength ),
    LegionPercent =< UserPercent,    
    % write("passed legionnaires_Disease"), nl,

    %--- is count is greater than or equal to count for hepatitis_A
    symptomListDisease(HepList, disease(hepatitis_A)),
    countSameElements(UserDiseaseList, HepList, HepCount),

    length(HepList, HepLength),
    HepPercent is ( ( 100 * HepCount ) / HepLength ),
    HepPercent =< UserPercent,     
    % write("passed hepatitis_A"), nl,
 
    %--- Check desired percent over the calculated UserPercent 
    Percent =< UserPercent,
    BestMatch = Disease.
%------------------------------------------------------------------------------------------------------
% bestMatch(UserDiseaseList, Output) Unifys Output to the disease that
%   has the highest number of matches of the user's symptoms to disease symptoms.
bestMatch(UserDiseaseList, BestMatch) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, UserCount),
    length(DiseaseList, UserLength),
    UserPercent is ( ( 100 * UserCount ) / UserLength ),

    %--- is count is greater than or equal to count for gastrointestinal_Illnesses
    symptomListDisease(GastroList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, GastroList , GastroCount),
    
    length(GastroList, GastroLength),
    GastroPercent is ( ( 100 * GastroCount ) / GastroLength ),
    GastroPercent =< UserPercent,
    % write("passed gastrointestinal_Illnesses"), nl,

    %--- is count is greater than or equal to count for influenza
    symptomListDisease(InfluenzaList, disease(influenza)),
    countSameElements(UserDiseaseList, InfluenzaList , InfluenzaCount),

    length(InfluenzaList, InfluenzaLength),
    InfluenzaPercent is ( ( 100 * InfluenzaCount ) / InfluenzaLength ),
    InfluenzaPercent =< UserPercent,    
    % write("passed influenza"), nl,

    %%%--- is count is greater than or equal to count for legionnaires_Disease
    symptomListDisease(LegionList, disease(gastrointestinal_Illnesses)),
    countSameElements(UserDiseaseList, LegionList, LegionCount),
    
    length(LegionList, LegionLength),
    LegionPercent is ( ( 100 * LegionCount ) / LegionLength ),
    LegionPercent =< UserPercent,    
    % write("passed legionnaires_Disease"), nl,

    %--- is count is greater than or equal to count for hepatitis_A
    symptomListDisease(HepList, disease(hepatitis_A)),
    countSameElements(UserDiseaseList, HepList, HepCount),

    length(HepList, HepLength),
    HepPercent is ( ( 100 * HepCount ) / HepLength ),
    HepPercent =< UserPercent,     
    % write("passed hepatitis_A"), nl,
 
    %--- Assign disease we think it is 
    BestMatch = Disease.

%------------------------------------------------------------------------------------------------------
% bestBayesMatch(UserDiseaseList, Output) Unifys Output to the disease that
%   has the highest totalWeight, where total weight is the sum of the importance of
%   present symptums, minus the sum of the importance of symptoms not present.
bestBayesMatch(UserSymptomList, BestBayes) :-
    % write('Symptom list: '), write(UserSymptomList), nl,
    disease(Disease), %set a disease
    % nl, write('disease: '), write(Disease), nl,
    getTotalWeight(UserSymptomList, Disease, UserTotalWeight), % find weight of UserSymptomList for given Disease
    % write(UserTotalWeight), nl,

    getTotalWeight(UserSymptomList, influenza, InfluenzaTotal), % find total for influenza
    InfluenzaTotal =< UserTotalWeight, % test if Users is greater than influenza
    % write('flu total: '), write(InfluenzaTotal), nl,
    % write('passed influenza'), nl,

    getTotalWeight(UserSymptomList, gastrointestinal_Illnesses, GastroTotal), % find total for gastrointestinal_Illnesses
    GastroTotal =< UserTotalWeight, % test if Users is greater than gastrointestinal_Illnesses
    % write('gastro total: '), write(GastroTotal), nl,
    % write('passed gastro'), nl,

    getTotalWeight(UserSymptomList, legionnaires_Disease, LegionTotal), % find total for legionnaries_Disease
    LegionTotal =< UserTotalWeight, % test if Users is greater than legionnaries_Disease
    % write('legion total: '), write(LegionTotal), nl,
    % write('passed legion'), nl,

    getTotalWeight(UserSymptomList, hepatitis_A, HepTotal), % find total for hepatitis_A
    HepTotal =< UserTotalWeight, % test is Users is greater than hepatitis_A
    % write('heptotal: '), write(HepTotal), nl,
    % write('passed hep'), nl, nl,

    BestBayes = Disease. % Disease is assigned iff it passes all tests and thus has the greatest total


%------------------------------------------------------------------------------------------------------
% Main Program
%------------------------------------------------------------------------------------------------------
%Start here
main :- 
    getSymptoms(UserSymptomList), % Get user symptoms
    %percentMatch(UserSymptomList, 70, Best), % Find best match
    (percentMatch(UserSymptomList, 70, Best) ->
        ( write('You likely have '), write(Best), nl ) ;
        main(UserSymptomList)
    ).

main(UserSymptomList) :-
    nl, write("Hmmmm, I think I need more information."), nl,
    write("How about I ask you some questions."), nl,
    (getMoreSymptoms(OtherSymptoms)) ->  %get rest of symptoms, when user inputs 'No.' getMoreSymptoms fails go to main3
        append(UserSymptomList, OtherSymptoms, NewUserSymptomList), %combine lists
        (percentMatch(NewUserSymptomList, 80, NewBest) -> % if the new list can pass a greater % test diagnose
            ( write('You likely have '), write(NewBest), nl ) ;
            main3(NewUserSymptomList) % else go to main3
        ) ;
        main3(UserSymptomList).

main3(UserSymptomList) :-
    % write('Made it to third main'), nl,
    bestMatch(UserSymptomList, BestMatch),
    bestBayesMatch(UserSymptomList, BestBayes), %find the bestBayesMatch with combined UserSymptomList
    write('You likely have '), write(BestBayes), write(', or you have '), write(BestMatch), nl, %output findings
    write('Thanks for visiting the doc. Make sure you get a lollipop'), nl.


%------------------------------------------------------------------------------------------------------
% UI helper functions
%------------------------------------------------------------------------------------------------------
% Ask user for symptoms -
getSymptoms(UserSymptoms) :-
    write('What symptoms do you have?'), nl,
    write('Enter a symptom list followed by a period.'), nl,
    write('like this [S1,S2,S3,...].'), nl,
    read(UserSymptoms),
    write('You entered: '), write(UserSymptoms), nl.

getMoreSymptoms(UserSymptoms) :-
    write('What other symptoms do you have?'), nl,
    write('Enter a symptom list followed by a period.'), nl,
    write('like this [S1,S2,S3,...]. Or enter "No."'), nl,
    read(UserSymptoms),
    not(isNo(UserSymptoms)),
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