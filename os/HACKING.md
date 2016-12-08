# Hacking guide

## ROM entry

The "entry" point for the OS is via the vector table defined in
``vector_table.s``.

## RESET vector

The reset vector is responsible for setting the initial state of the machine and
branching to the C-function ``start()``. On reset the following initialisation
steps are performed:

1. Interrupts are disabled
1. Aritmetic is set to binary-mode
1. The hardware stack pointer is initialised to $1FF
1. The CPU is switched to "native" mode
1. The index and accumulator are set to 8-bit
1. The direct page is cleared to all zeros
1. The C stack pointer is written to the direct-page word at ``sp``
1. The IRQ handler chain is initialised (see below)
1. Control is passed to the C ``start()`` function

## IRQ vector

The in-ROM IRQ handler first saves the processor registers on the stack and
jumps to the address stoed in the zero-page word ``irq_first_handler``. This is
initialised to point to an IRQ handler "tail" which restores registers from the
stack and exit the interrupt handler.

Should a driver want to patch itself into the interrupt handler flow it should:

1. Disable interrupts
1. Copy the word stored in ``irq_first_handler`` to some convenient location
1. Update the word stored in ``irq_first_handler`` to point to the driver's IRQ
   handler function.
1. Ensure that the driver's IRQ handler jumps to the previous
   ``irq_first_handler`` address after it is finished.
1. Enable interrupts

The macro ``irq_add_handler`` is defined in ``macros.inc`` to make this process
easier.

