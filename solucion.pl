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


esUnBarrioCopado(Barrio):-
    viveEn(Persona, _ , Barrio),
    forall((viveEn(Persona2,_, Barrio), Persona \= Persona2), viveEnLugarCopado(Persona2)).
    

esPropiedadBarata(casa(Metros)):-
    Metros < 90.
esPropiedadBarata(loft(Anio)):-
    Anio < 2005.
esPropiedadBarata(departamento(ambientes(Ambientes),banios(_))):-
    Ambientes < 3.


esUnBarrioCaro(Barrio):-
    viveEn(_, Propiedad , Barrio),
    forall((viveEn(_, Propiedad2, Barrio), Propiedad \= Propiedad2) , not(esPropiedadBarata(Propiedad2))).


tasa(juan, 150000).
tasa(nico, 80000).
tasa(alf, 75000).
tasa(julian, 140000).
tasa(vale, 95000).
tasa(fer, 60000).

sublista([],[]).
sublista([_|Cola], Sublista):- sublista(Cola,Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-sublista(Cola,Sublista).

comprar(Valor, Casas):-
    findall(Casa, tasa(Persona,Valor), CasasPosibles),
    sublista(CasasPosibles, Casas),
    Casas \= [].

quieroComprar(250000,Casas,MeQuedoCon):-
    tasa(Persona, Valor),
    forall((comprar(Valor2,Casas), Valor \= Valor2), 250000 - Valor2 = MeQuedoCon).
