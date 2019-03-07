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

  stage1.cpp --

  Original Author: Martin Janssen, Synopsys, Inc., 2002-02-15

 *****************************************************************************/

/*****************************************************************************

  MODIFICATION LOG - modifiers, enter your name, affiliation, date and
  changes you are making here.

      Name, Affiliation, Date:
  Description of Modification:

 *****************************************************************************/

/* Filename stage1.cc */
/* This is the implementation file for synchronous process `stage1' */

#include "stage1.h"
#include "f_stage1.h"

void stage1::entry()
{
  double a, b;

  a = 20.0;
  b = 5.0;
  while (true) {
    sum.write(a+b);
    diff.write(a-b);
    wait();
    a = in1.read();
    b = in2.read();
  }
} // end of entry function

void f_stage1(const char *NAME,
	      sc_clock& CLK,
	      const sc_signal<double>& IN1,
	      const sc_signal<double>& IN2,
	      sc_signal<double>& SUM,
	      sc_signal<double>& DIFF)
{
  SC_NEW(stage1(NAME, CLK, IN1, IN2, SUM, DIFF));
}
