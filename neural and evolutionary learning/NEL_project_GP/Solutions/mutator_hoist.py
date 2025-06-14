def hoist_mtn(repr_):
    """ Implements the hoist mutation

    The hoist mutation selects a random subtree R from solution's
    representation and replaces it with a random subtree R' taken
    from itself, i.e., a random subtree R' is selected from R and
    replaces it in the representation (it is 'hoisted').

    Parameters
    ----------
    repr_ : list
        Parent's representation.

    Returns
    -------
    list
        The offspring obtained from replacing a randomly selected
        subtree in the parent by a random tree.
    """
    # Get a subtree (R)
    start, end = get_subtree(repr_)
    subtree = repr_[start:end]
    # Get a subtree of the subtree to hoist (R')
    sub_start, sub_end = get_subtree(subtree)
    hoist = subtree[sub_start:sub_end]
    # Returns the result as lists' concatenation
    return repr_[:start] + hoist + repr_[end:]