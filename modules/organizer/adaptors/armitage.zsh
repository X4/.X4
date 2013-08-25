#
# armitage - GUI frontend for metasploit
#

armitage_props=$(dotfile armitage config file config.props)
alias armitage="armitage --client $armitage_props"