/*****************************************************************************

  Licensed to Accellera Systems Initiative Inc. (Accellera) under one or
  more contributor license agreements.  See the NOTICE file distributed
  with this work for additional information regarding copyright ownership.
  Accellera licenses this file to you under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with the
  License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
  implied.  See the License for the specific language governing
  permissions and limitations under the License.

 *****************************************************************************/

/*****************************************************************************

  test.h --

  Original Author: Martin Janssen, Synopsys, Inc., 2002-02-15

 *****************************************************************************/

/*****************************************************************************

  MODIFICATION LOG - modifiers, enter your name, affiliation, date and
  changes you are making here.

      Name, Affiliation, Date:
  Description of Modification:

 *****************************************************************************/

// sc_signal test;
// interface methods -- register_port()

#ifndef TEST_H
#define TEST_H

#include "systemc.h"

template <class T>
class writer
: public sc_module
{
public:

    // output port
    sc_out<T> out;

    // constructor
    writer( sc_module_name )
        {}
};

template <class T>
class top
: public sc_module
{
public:

    // channel
    sc_signal<T> sig;

    // modules
    writer<T> w1;
    writer<T> w2;

    // constructor
    top( sc_module_name )
    : sig(), w1( "w1" ), w2( "w2" )
    {
        w1.out( sig );
        w2.out( sig );
    }
};

#endif

// Taf!
