/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  v2206                                 |
|   \\  /    A nd           | Website:  www.openfoam.com                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    `format'      binary;
    class       dictionary;
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
dnl> -----------------------------------------------------------------
dnl> <STANDARD DEFINTIONS>
dnl>
changecom(//)changequote([,]) dnl>
define(calc, [esyscmd(perl -e 'print ($1)')]) dnl>
define(VCOUNT, 0)  dnl>
define(vlabel, [[// ]pt VCOUNT ($1) define($1, VCOUNT)define([VCOUNT], incr(VCOUNT))])  dnl>
dnl>
dnl> </STANDARD DEFINTIONS>
dnl> -----------------------------------------------------------------
dnl>
define(r1, 0.01) dnl>
define(r2, 0.5) dnl>
define(xr, calc(0*r1)) dnl>
define(h, calc(0*r1)) dnl>
define(l, calc(xr + 30*r1)) dnl>
define(w, 0.001) dnl>
define(Sin, 0.7071067812) dnl>   == sin(45) dnl>
dnl>
define(y0, 0) dnl>
define(y1, calc(h/2 + y0 - r2*Sin)) dnl>
define(y2, calc(h/2 + y0 - r1*Sin)) dnl>
define(y3, calc(h/2 + y0 + r1*Sin)) dnl>
define(y4, calc(h/2 + y0 + r2*Sin)) dnl>
define(y5, calc(y0 + h)) dnl>
dnl>
define(x0, 0) dnl>
define(x1, calc(xr + x0 - r2*Sin)) dnl>
define(x2, calc(xr + x0 - r1*Sin)) dnl>
define(x3, calc(xr + x0 + r1*Sin)) dnl>
define(x4, calc(xr + x0 + r2*Sin)) dnl>
define(x5, calc(x0 + l)) dnl>
dnl>
define(w0, -0.001) dnl>
define(w1, calc(w0 + w)) dnl>
dnl>
define(N, 20) dnl>
define(hex2D, hex ($1f $2f $3f $4f $1b $2b $3b $4b)) dnl>
dnl>
dnl>
dnl>
define(nScale, 10)
define(nx1, calc(nScale*30))  dnl>
define(nx2, calc(nScale*10))  dnl>
define(nx3, calc(nScale*100))  dnl>
define(ny1, calc(nScale*20))  dnl>
define(ny2, nx2)  dnl>
define(ny3, ny1)  dnl>
define(nr, calc(nScale*20))  dnl>
define(nz, 1)  dnl>
dnl>
dnl>
define(hex2D, hex ($1b $2b $3b $4b $1f $2f $3f $4f)) dnl>
define(quad2D, ($1f $1b $2b $2f))  dnl>
define(frontQuad, ($1f $2f $3f $4f)) dnl>
define(backQuad, ($4b $3b $2b $1b)) dnl>
dnl>
dnl> </STANDARD DEFINTIONS>
dnl> -----------------------------------------------------------------
dnl>
dnl>

scale   1;

vertices
(
    (x1 y1 w0)  vlabel(p12f)
    (x4 y1 w0)  vlabel(p13f)
    (x4 y4 w0)  vlabel(p14f)
    (x1 y4 w0)  vlabel(p15f)
    (x2 y2 w0)  vlabel(p16f)
    (x3 y2 w0)  vlabel(p17f)
    (x3 y3 w0)  vlabel(p18f)
    (x2 y3 w0)  vlabel(p19f)

    (x1 y1 w1)  vlabel(p12b)
    (x4 y1 w1)  vlabel(p13b)
    (x4 y4 w1)  vlabel(p14b)
    (x1 y4 w1)  vlabel(p15b)
    (x2 y2 w1)  vlabel(p16b)
    (x3 y2 w1)  vlabel(p17b)
    (x3 y3 w1)  vlabel(p18b)
    (x2 y3 w1)  vlabel(p19b)
);

blocks
(
    // 8
    hex2D(p12, p16, p19, p15) porosity
    ( nr ny2 nz ) simpleGrading (0.025 1 1)

    // 9
    hex2D(p12, p13, p17, p16) porosity
    ( nx2 nr nz ) simpleGrading (1 0.025 1)

    // 10
    hex2D(p17, p13, p14, p18) porosity
    ( nr ny2 nz ) simpleGrading (40 1 1)

    // 11
    hex2D(p19, p18, p14, p15) porosity
    ( nx2 nr nz ) simpleGrading (1 40 1)
);

edges
(
    // Inner circle
    arc  4 5 (calc(xr + x0) calc(h/2 + y0 - r1) w0)
    arc  5 6 (calc(xr + x0 + r1) calc(h/2 + y0) w0)
    arc  6 7 (calc(xr + x0) calc(h/2 + y0 + r1) w0)
    arc  7 4 (calc(xr + x0 - r1) calc(h/2 + y0) w0)

    arc  12 13 (calc(xr + x0) calc(h/2 + y0 - r1) w1)
    arc  13 14 (calc(xr + x0 + r1) calc(h/2 + y0) w1)
    arc  14 15 (calc(xr + x0) calc(h/2 + y0 + r1) w1)
    arc  15 12 (calc(xr + x0 - r1) calc(h/2 + y0) w1)

    // Outer circle
    arc  0 1 (calc(xr + x0) calc(h/2 + y0 - r2) w0)
    arc  1 2 (calc(xr + x0 + r2) calc(h/2 + y0) w0)
    arc  2 3 (calc(xr + x0) calc(h/2 + y0 + r2) w0)
    arc  3 0 (calc(xr + x0 - r2) calc(h/2 + y0) w0)

    arc  8 9 (calc(xr + x0) calc(h/2 + y0 - r2) w1)
    arc  9 10 (calc(xr + x0 + r2) calc(h/2 + y0) w1)
    arc  10 11 (calc(xr + x0) calc(h/2 + y0 + r2) w1)
    arc  11 8 (calc(xr + x0 - r2) calc(h/2 + y0) w1)
);

defaultPatch
{
    name    frontAndBack;
    type    empty;
}

boundary
(
    outlet
    {
        type        patch;
        faces
        (
            quad2D(p12, p13)
            quad2D(p13, p14)
            quad2D(p14, p15)
            quad2D(p15, p12)
        );
    }

    inlet
    {
        type        patch;
        faces
        (
            quad2D(p16, p17)
            quad2D(p17, p18)
            quad2D(p18, p19)
            quad2D(p19, p16)
        );
    }
);

mergePatchPairs
(
);

// ************************************************************************* //
