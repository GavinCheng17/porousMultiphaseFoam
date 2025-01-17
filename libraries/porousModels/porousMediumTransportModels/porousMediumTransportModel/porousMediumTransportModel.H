/*---------------------------------------------------------------------------*\
  		  _______  ____    ____  ________  
 		 |_   __ \|_   \  /   _||_   __  | 
   		   | |__) | |   \/   |    | |_ \_| 
   		   |  ___/  | |\  /| |    |  _|    
    		  _| |_    _| |_\/_| |_  _| |_     
   		 |_____|  |_____||_____||_____|    
   	     Copyright (C) Toulouse INP, Pierre Horgue

License
    This file is part of porousMultiphaseFoam, an extension of OpenFOAM
    developed by Pierre Horgue (phorgue@imft.fr) and dedicated to multiphase 
    flows through porous media.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

Namespace
    Foam::porousMediumTransportModel

Description
    A namespace for various transport models in porous media implementations.

Class
    Foam::porousMediumTransportModel

Description
    An abstract base class for transport models in porous medium (simple or
    dual porosity)

SourceFiles
    porousMediumTransportModel.C
    porousMediumTransportModelNew.C

\*---------------------------------------------------------------------------*/

#ifndef porousMediumTransportModel_H
#define porousMediumTransportModel_H

#include "surfaceFields.H"
#include "volFields.H"
#include "porousMediumModel.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
             Class porousMediumTransportModel Declaration
\*---------------------------------------------------------------------------*/

class porousMediumTransportModel
{
protected:

    // Protected data
    //- Name of the main saturation field
    const word Sname_;

    //- Reference to the main dictionary
    const dictionary& transportProperties_;

    //- Reference to the 
    const porousMediumModel& pmModel_;

    //- Disallow copy construct
    porousMediumTransportModel(const porousMediumTransportModel&);

    //- Disallow default bitwise assignment
    void operator=(const porousMediumTransportModel&);

public:

    //- Runtime type information
    TypeName("porousMediumTransportModel");

    // Declare run-time constructor selection table

    declareRunTimeSelectionTable
    (
        autoPtr,
        porousMediumTransportModel,
        dictionary,
        (
            const word Sname,
            const fvMesh& mesh,
            const dictionary& transportProperties,
            const porousMediumModel& pmModel,
            const word mediumName
        ),
        (Sname, mesh, transportProperties, pmModel, mediumName)
    );

    // Selectors

    //- Return a reference to the selected porousMedium model
    static autoPtr<porousMediumTransportModel> New
    (
        const word Sname,
        const fvMesh& mesh,
        const dictionary& transportProperties,
        const porousMediumModel& pmModel,
        const word mediumName = ""
    );

    // Constructors

    //- Construct from components
    porousMediumTransportModel
    (
        const word Sname,
        const fvMesh& mesh,
        const dictionary& transportProperties,
        const porousMediumModel& pmModel,
        const word mediumName = ""
    );

    //- Destructor
    virtual ~porousMediumTransportModel()
        {}

    // Member Functions
    const word& Sname() const {return Sname_;}

    //- Return transport properties
    const dictionary& transportProperties() const {return transportProperties_;}

    //- Return porousMediumModel
    const porousMediumModel& pmModel() const {return pmModel_;}

    //- Correct/compute transport in porous medium
    virtual void correct() = 0;

};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************************************************************* //
