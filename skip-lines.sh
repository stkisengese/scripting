# ls -l | awk 'NR % 2 == 0'

# alternatively
ls -l | sed -n '2~2p'