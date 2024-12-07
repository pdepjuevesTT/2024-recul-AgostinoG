% Solución en Prolog
viveEn(juan, casa(120), almagro).
viveEn(nico, departamento(ambientes(3), banios(2)), almagro).
viveEn(alf, departamento(ambientes(3), banios(1)), almagro).
viveEn(julian, loft(2000), almagro).
viveEn(vale, departamento(ambientes(4), banios(1)), flores).
viveEn(fer, casa(110), flores).

viveEnLugarCopado(Persona):-
    viveEn(Persona, casa(Metros), _),
    Metros > 100.
viveEnLugarCopado(Persona):-
    viveEn(Persona, departamento(ambientes(Ambientes),banios(_)), _),
    Ambientes > 3.
viveEnLugarCopado(Persona):-
    viveEn(Persona, departamento(ambientes(_),banios(Banios)), _),
    Banios > 1.
viveEnLugarCopado(Persona):-
    viveEn(Persona, loft(Anio),_),
    Anio > 2015.

cuantasPersonasViven(Persona,Barrio, Personas):-
    viveEn(Persona,_,Barrio),
    findall(Persona, viveEn(Persona,_,Barrio), Personas).
    

esUnBarrioCopado(Barrio):-
    viveEn(Persona, _ , Barrio),
    forall(cuantasPersonasViven(Persona,Barrio, Personas), viveEnLugarCopado(Persona)).

esPropiedadBarata(casa(Metros)):-
    Metros < 90.
esPropiedadBarata(loft(Anio)):-
    Anio < 2005.
esPropiedadBarata(departamento(ambientes(Ambientes),banios(_))):-
    Ambientes < 3.

esUnBarrioCaro(Barrio):-
    viveEn(_, Propiedad , Barrio),
    forall(viveEn(_, Propiedad, Barrio), not(esPropiedadBarata(Propiedad))).

vale(juan, 150000).
vale(nico, 80000).
vale(alf, 75000).
vale(julian, 140000).
vale(vale, 95000).
vale(fer, 60000).

sublista([],[]).
