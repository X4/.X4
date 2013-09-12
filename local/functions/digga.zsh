## Dig for all available DNS records
## - Usage: digga ns1.crbs.ucsd.edu
digga() {
    dig +nocmd $1 any +multiline +noall +answer
}