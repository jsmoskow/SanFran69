#!


# To do this, save this as a file, and add & to the end to make it backgrounded
# To send this to the pfsense, use curl -O https:....
    # easyrule <action> <interface> <parameters>
# easyrule pass <interface> <protocol> <source address> <destination address> [destination port]
# easyrule block <interface> <source address>

# get the output of the rules

# Make sure this is staged properly


#cp /tmp/rules.debug /etc/rulescfg.debug
while :
do
rm /tmp/rules.debug
pfctl -f /etc/rulescfg.debug
pfctl -F states
sleep 1
done