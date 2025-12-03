ls -l | awk 'NR % 2 == 0'

# alternatively
# ls -l | sed -n 'n;p'