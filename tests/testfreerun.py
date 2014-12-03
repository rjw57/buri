"""
Test Buri processor in free-running mode.

"""
# pylint: disable=no-name-in-module
from nose.tools import assert_equal

from burisim import BuriSim

def test_free_run():
    sim = BuriSim()

    # Fill memory with NOPs
    with sim.writable_rom():
        for addr in range(0, 0x10000):
            sim.mem[addr] = 0xEA

    # Reset
    sim.reset()

    # Check PC has been loaded from reset vector
    assert_equal(sim.mpu.pc, 0xEAEA)

    # After one step, PC should advance
    sim.step()
    assert_equal(sim.mpu.pc, 0xEAEB)
