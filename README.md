# Modeliavimas-lab5

## Užduotis: diferencialinių lygčių sprendimas skaitiniais metodais

Keturi grandinių variantai iš `DiffEqs.pdf`:

| Nr. | Nuoseklus elementas | Elementas į bendrą laidą | Išėjimas matuojamas |
|---|---|---|---|
| 1 | R | C | per C |
| 2 | R | L | per L |
| 3 | C | R | per R |
| 4 | L | R | per R |

1. Užrašykite grandinės diferencialinę lygtį, išspręskite Eulerio ir `ode45()` metodais, nubraižykite Uout(t).
2. Raskite analitinį sprendinį naudodami `dsolve()`.
3. Nubraižykite skaitinių ir analitinio sprendinių skirtumus.

Sąlygos: **Uin=1 V** intervale [0,0.5) s, **Uin=0 V** intervale [0.5,1] s, **τ=0.1 s**.

Pradinė būsena PDF nenurodyta. Laikoma, kad kondensatorius iškrautas, o ritės srovė lygi nuliui: **q(0)=0**.

Šaltinis: dėstytojo pateikti `DiffEqs.pdf` ir `Euler.m`.

## Paleidimas

Atidarykite [lab5_main.m](lab5_main.m) ir paspauskite **Run**. [Euler.m](Euler.m) turi būti tame pačiame aplanke. Funkcijai `dsolve()` reikalingas **Symbolic Math Toolbox**. Jei jo nėra, skriptas naudoja tas pačias analitines eksponentines formules ir praneša, kad `dsolve()` nebuvo vykdyta.

Pagal nutylėjimą vykdomi visi keturi variantai (`variants = 1:4`). Skaičiavimas suskaidytas ties įėjimo šuoliu t=0.5 s; Eulerio metodui naudojama 500 žingsnių kiekvienoje dalyje.

Paaiškinimas ir lygčių išvedimas: [SOLUTION.md](SOLUTION.md).
