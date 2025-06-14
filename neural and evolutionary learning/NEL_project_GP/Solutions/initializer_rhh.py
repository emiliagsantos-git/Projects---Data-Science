
def rhh(sspace, n_sols):
    """ Implements Ramped Half and Half initialization algorithm

    Implements the Ramped Half and Half, which, by itself, uses
    Full and Grow.

    Parameters
    ----------
    sspace : dict
        Problem-specific solve space (𝑆).
    n_sols : int
        The number of solutions in the population

    Returns
    -------
    pop : list
        A list of program elements which represents the population
        initial of computer programs (candidate solutions). Each
        program is a list of program's elements that follows a
        LISP-based formulation and Polish pre-fix notation.
    """
    pop = []
    n_groups = sspace["max_init_depth"]
    group_size = math.floor((n_sols / 2.) / n_groups)
    for group in range(n_groups):
        max_depth_group = group + 1
        for i in range(group_size):
            sspace_group = sspace
            sspace_group["max_init_depth"] = max_depth_group
            pop.append(full(sspace_group))
            pop.append(grow(sspace_group))
    while len(pop) < n_sols:
        pop.append(grow(sspace_group) if random.randint(0, 1) else full(sspace_group))
    return pop