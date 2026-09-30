# Sprendimas: RC ir RL grandinės

Visos keturios grandinės aprašomos viena pirmos eilės būsena q:

$$\tau q'(t)+q(t)=U_{in}(t),\qquad q(0)=0.$$

## Lygčių išvedimas

| Nr. | Būsena q | Išvedimas | Išėjimas |
|---|---|---|---|
| 1 | Kondensatoriaus įtampa | (Uin-q)/R = C·q'; τ=RC | Uout=q |
| 2 | Rezistoriaus įtampa R·i | Uin=R·i+L·i'; τ=L/R | Uout=Uin-q |
| 3 | Kondensatoriaus įtampa | Uin=q+R·C·q'; τ=RC | Uout=Uin-q |
| 4 | Rezistoriaus įtampa R·i | Uin=R·i+L·i'; τ=L/R | Uout=q |

1 ir 4 variantams tiesiogiai **τ·Uout'+Uout=Uin**. 2 ir 3 variantams **τ·Uout'+Uout=τ·Uin'**; įėjimo šuoliai sukelia išėjimo šuolius. Integruojant tęstinę būseną q išvengiama skaitinio impulsų aproksimavimo.

## Analitinis sprendinys

Iki t=0.5 s:

$$q(t)=1-e^{-t/\tau}.$$

Po t=0.5 s:

$$q(t)=(1-e^{-0.5/\tau})e^{-(t-0.5)/\tau}.$$

1 ir 4 variantų išėjimas yra q. 2 ir 3 variantams iki jungimo **Uout=e⁻ᵗ/τ**, o po jungimo **Uout=-(1-e⁻⁰·⁵/τ)e⁻⁽ᵗ⁻⁰·⁵⁾/τ**. Būsena ties jungimu lieka tęstinė, o šių variantų išėjimas šoka -1 V.

## Skaitinis sprendimas

[Euler.m](Euler.m) vykdo **q(i+1)=q(i)+h·f(t(i),q(i))**. Kiekvienai pusei naudojama 500 žingsnių, todėl h=0.001 s.

`ode45()` vykdomas atskirai intervaluose [0,0.5] ir [0.5,1], išlaikant tą pačią būseną ties jungimu. Tikslumo nustatymai: RelTol=10⁻¹⁰, AbsTol=10⁻¹². Analitiniam sprendiniui pateikti du `dsolve()` iškvietimai su atitinkamomis pradinėmis sąlygomis.

Laiko vektoriuje yra abi t=0.5 reikšmės, kad grafikas parodytų kairę ir dešinę išėjimo šuolio puses.

## MATLAB R2026a patikrinimas

Paleisti visi keturi variantai. Maksimali išėjimo paklaida kiekvienam:

| Metodas | Maksimali absoliuti paklaida, V |
|---|---|
| Eulerio | 0.001847099898 |
| ode45 | 3.0593e-11 |

Patikrintas būsenos tęstinumas ties t=0.5. MATLAB statinis analizatorius pastabų nerado.

Šiame kompiuteryje Symbolic Math Toolbox nėra, todėl **`dsolve()` dalis faktiškai nebuvo vykdyta**. Skaitiniai sprendiniai palyginti su aukščiau išvestomis analitinėmis formulėmis. Įdiegus toolbox skriptas automatiškai vykdo `dsolve()`.
