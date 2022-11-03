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
disease(gastrointestinal_Illnesses).
disease(influenza).
disease(legionnaires_Disease).
disease(hepatitis_A).

%%%%%%%%%% symptomOf(Symptom, Disease)
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
symptomOf(vomiting, gastrointestinal_Illnesses).
symptomOf(diarrhea, gastrointestinal_Illnesses).
symptomOf(sore_Throat, influenza).
symptomOf(yellow_Skin, hepatitis_A).

%%%%%%%%%% symptomListDisease([Symptom1, Symptom2, ... , SymptomN], disease(Disease))
symptomListDisease([cough, headache, fever, aches], disease(legionnaires_Disease)).
symptomListDisease([vomiting, diarrhea], disease(gastrointestinal_Illnesses)).
symptomListDisease([fatigue, headache, fever, aches, vomiting, yellow_Skin], disease(hepatitis_A)).
symptomListDisease([cough, fever, aches, vomiting, sore_Throat], disease(influenza)).

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
    C is C1 + 1 , !.
count(H,[_|T],C) :-
    count(H,T,C).

compareUserDiseaseList(UserDiseaseList, DiseaseList, Count) :-
    symptomListDisease(DiseaseList, disease(Disease)),
    countSameElements(UserDiseaseList, DiseaseList, Count),
    write(Disease), write(' '), write(Count), nl.



