# -*- coding: utf-8 -*-
# Copyright (c) 2018 The Regents of the University of California
# All Rights Reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met: redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer;
# redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution;
# neither the name of the copyright holders nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Authors: Ayaz Akram, Jason Lowe-Power

"""
Main system for all SE experiments.

This contains the default caches and memory that will be shared between all
of the experiments.

The system does not have a CPU model, this must be specified by a subclass.
"""

import m5
from m5.objects import *
from m5.objects import Cache
#from caches import *

class L1Cache(Cache):
    assoc = 2
    tag_latency = 2
    data_latency = 2
    response_latency = 2
    mshrs = 4
    tgts_per_mshr = 20
    
    def connectCPU(self, cpu):
    # need to define this in a base class!
        raise NotImplementedError

    def connectBus(self, bus):
        self.mem_side = bus.slave

class L1ICache(L1Cache):
    size = '16kB'

    def connectCPU(self, cpu):
        self.cpu_side = cpu.icache_port

class L1DCache(L1Cache):
    size = '64kB'

    def connectCPU(self, cpu):
        self.cpu_side = cpu.dcache_port

class BaseTestSystem(System):
    """Base class for all test systems.

    Each test system must set its own CPU model by setting the CPUModel
    attribute.
    """
	
    # These *must* be overridden by a subclass
    _CPUModel = BaseCPU
    _MemoryModel = SimpleMemory

    def __init__(self):
        super(BaseTestSystem, self).__init__()
        self.clk_domain = SrcClockDomain(clock="1GHz",
                                         voltage_domain=VoltageDomain())

        self.mem_mode = 'timing'
        self.mem_ranges = [AddrRange('512MB')]

        self.cpu = self._CPUModel()
        self.membus = SystemXBar()

        self.cpu.icache = L1ICache()
        self.cpu.dcache = L1DCache()

        self.cpu.icache.connectCPU(self.cpu)
        self.cpu.dcache.connectCPU(self.cpu)

        self.cpu.icache.connectBus(self.membus)
        self.cpu.dcache.connectBus(self.membus)

        self.cpu.createInterruptController()
        if m5.defines.buildEnv['TARGET_ISA'] == "x86":
            self.interrupt_xbar = SystemXBar()
            self.cpu.interrupts[0].pio = self.interrupt_xbar.master
            self.cpu.interrupts[0].int_master = self.interrupt_xbar.slave
            self.cpu.interrupts[0].int_slave = self.interrupt_xbar.master

        self.system_port = self.membus.slave
        self.mem_ctrl = self._MemoryModel()
        self.mem_ctrl.range = self.mem_ranges[0]
        self.mem_ctrl.port = self.membus.master
            

    def setTestBinary(self, binary_path, binary_input):
        """Set up the SE process to execute the binary at binary_path"""
        from m5 import options
        output = os.path.join(options.outdir, 'stdout')

        self.cpu.workload = Process(output=output,
                                    cmd=[binary_path] + binary_input.split())
        self.cpu.createThreads()
