
def full(sspace):
    """ Implements Full initialization algorithm

    The probability of selecting a constant from the set of terminals
    is controlled by the value in "p_constants" key, defined in sspace
    dictionary, and equals 0.5*sspace["p_constants"].

    Parameters
    ----------
    sspace : dict
        Problem instance's solve-space.

    Returns
    -------
    program : list
        A list of program elements which represents an initial computer
        program (candidate solution). The program follows LISP-based
        formulation and Polish pre-fix notation.
    """
    function_ = random.choice(sspace['function_set'])
    program = [function_]
    terminal_stack = [function_.arity]

    while terminal_stack:
        depth = len(terminal_stack)

        if depth < sspace['max_init_depth']:
            function_ = random.choice(sspace['function_set'])
            program.append(function_)
            terminal_stack.append(function_.arity)
        else:
            terminal = Terminal(
                constant_set=sspace['constant_set'],
                p_constants=sspace['p_constants'],
                n_dims=sspace['n_dims'],
                device=sspace['device']
            ).initialize()
            program.append(terminal)
            terminal_stack[-1] -= 1
            while terminal_stack[-1] == 0:
                terminal_stack.pop()
                if not terminal_stack:
                    return program
                terminal_stack[-1] -= 1
    return None


def prm_full(sspace):
    """ Implements Full initialization algorithm

    The library's interface restricts variation operators' parameters
    to solutions' representations only. However, the functioning of
    some of the GP's variation operators requires random trees'
    generation - this is the case of the sub-tree mutation, the
    geometric semantic operators, ... In this sense, the variation
    functions' enclosing scope does not contain enough information to
    generate the initial trees. To remedy this situation, closures are
    used as they provide the variation functions the necessary outer
    scope for trees' initialization: the solve space. Moreover, this
    solution, allows one to have a deeper control over the operators'
    functioning - an important feature for the research purposes.

    Parameters
    ----------
    sspace : dict
        Problem instance's solve-space.

    Returns
    -------
    full_ : function
        A function which implements Full initialization algorithm,
        which uses the user-specified solve space for trees'
        initialization.
    """
    def full_():
        """ Implements Full initialization algorithm

        Implements Full initialization algorithm, which uses the user-
        specified solve space for trees' initialization.

        Returns
        -------
        program : list
            A list of program elements which represents an initial computer
            program (candidate solution). The program follows LISP-based
            formulation and Polish pre-fix notation.
        """
        function_ = random.choice(sspace['function_set'])
        program = [function_]
        terminal_stack = [function_.arity]

        while terminal_stack:
            depth = len(terminal_stack)

            if depth < sspace['max_init_depth']:
                function_ = random.choice(sspace['function_set'])
                program.append(function_)
                terminal_stack.append(function_.arity)
            else:
                terminal = Terminal(
                    constant_set=sspace['constant_set'],
                    p_constants=sspace['p_constants'],
                    n_dims=sspace['n_dims'],
                    device=sspace['device']
                ).initialize()
                program.append(terminal)
                terminal_stack[-1] -= 1
                while terminal_stack[-1] == 0:
                    terminal_stack.pop()
                    if not terminal_stack:
                        return program
                    terminal_stack[-1] -= 1
        return None

    return full_
