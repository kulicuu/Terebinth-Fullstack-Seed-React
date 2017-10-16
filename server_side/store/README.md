# State Management : 'Concordance'



In some situations, Node.js servers that are highly scaled are better individually stateless -- keeping no memory of HTTP transactions, without 'sticky-sessions', possibly sharing a kind of low-latency state via clustered Redis nodes.

Still, maintaining state can be crucial at times, whether it's a central architectural choice, or just for individual-node ancillary tasks rather than part of core functionality.  In this case we maintain stateful Node.js with a pattern borrowed from my implementation of the Redux pattern. The pattern can function independently alongside stateless API functionality.
