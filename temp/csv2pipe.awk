BEGIN { FS=SUBSEP; OFS="|" }

{
  result = setcsv($0, ",")
  print
}

# setcsv(str, sep) - parse CSV (MS specification) input
# str, the string to be parsed. (Most likely $0.)
# sep, the separator between the values.
#
# After a call to setcsv the parsed fields are found in $1 to $NF.
# setcsv returns 1 on sucess and 0 on failure.
#
# By Peter Strvmberg aka PEZ.
# Based on setcsv by Adrian Davis. Modified to handle a separator
# of choice and embedded newlines. The basic approach is to take the
# burden off of the regular expression matching by replacing ambigious
# characters with characters unlikely to be found in the input. For
# this the characters "\035".
#
# Note 1. Prior to calling setcsv you must set FS to a character which
#         can never be found in the input. (Consider SUBSEP.)
# Note 2. If setcsv can't find the closing double quote for the string
#         in str it will consume the next line of input by calling
#         getline and call itself until it finds the closing double
#         qoute or no more input is available (considered a failiure).
# Note 3. Only the "" representation of a literal quote is supported.
# Note 4. setcsv will probably missbehave if sep used as a regular
#         expression can match anything else than a call to index()
#         would match.
#
function setcsv(str, sep, i) {
  gsub(/""/, "\035", str)
  gsub(sep, FS, str)

  while (match(str, /"[^"]*"/)) {
    middle = substr(str, RSTART+1, RLENGTH-2)
    gsub(FS, sep, middle)
    str = sprintf("%.*s%s%s", RSTART-1, str, middle,
      substr(str, RSTART+RLENGTH))
  }
  if (index(str, "\"")) {
    return ((getline) > 0) ? setcsv(str (RT != "" ? RT : RS) $0, sep) : !setcsv(str "\"", sep)
  } else {
    gsub(/\035/, "\"", str)
    $0 = str

    for (i = 1; i <= NF; i++)
      if (match($i, /^"+$/))
        $i = substr($i, 2)

    $1 = $1 ""
    return 1
  }
}
