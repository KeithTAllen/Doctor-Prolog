%%%%%%%%%%
%%% Basic Rules 
%%%%%%%%%%

% Symptoms 
symptom(cough).
symptom(fatigue).
symptom(headache).
symptom(fever).
symptom(aches).
symptom(vomiting).
symptom(sore_Throat).
symptom(yellow_Skin).

disease(gastrointestinal_Illnesses).
disease(influenza).
disease(legionnaires_Disease).
disease(hepatitis_A).

symptomOf(cough, influenza).
symptomOf(cough, legionnaires_Disease).
symptomOf(fatigue, influenza).
symptomOf(fatigue, hepatitis_A).

symptomOf(headache, legionnaires_Disease).
symptomOf(headache, hepatitis_A).

symptomOf(fever, influenza).
symptomOf(fever, legionnaires_Disease).
symptomOf(fever, hepatitis_A).

symptomOf(aches, influenza).
symptomOf(aches, legionnaires_Disease).
symptomOf(aches, hepatitis_A). 

symptomOf(vomiting, influenza).
symptomOf(vomiting, hepatitis_A).

symptomOf(sore_Throat, influenza).

symptomOf(yellow_Skin, hepatitis_A).

symptomOf(sore_Throat, influenza).

% Diseases to work with 

% Base Case
countSameElements([],[_|_],0).
countSameElements([H1|T1],[H2|T2],SetCount) :-
    count(H1,[H2|T2],Count),
    countSameElements(T1,[H2|T2],SetCount1),
    SetCount is Count + SetCount1.
% Count-------------------------------------------------
count(_,[],0). % base case
count(H,[H|T],C) :-
    count(H,T,C1),
    C is C1 + 1.
count(H,[_|T],C) :-
    count(H,T,C).




