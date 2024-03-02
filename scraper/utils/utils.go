package utils

import (
	"html"
	"regexp"
)

var convertToLF = regexp.MustCompile(`[\r\n]`)
var htmlBreaks = regexp.MustCompile(`<br ?\/?>`)
var leadingTrailingVWS = regexp.MustCompile(`^\n+|\n+$`)
var leadingTrailingHWS = regexp.MustCompile(`(?m)^[^\S\r\n]+|[^\S\r\n]+$`)
var redundantILS = regexp.MustCompile(`[^\S\r\n]{2,}`)
var redundantNL = regexp.MustCompile(`\n{3,}`)

func SanitizeString(input string) string {
	input = html.UnescapeString(html.UnescapeString(input))
	input = convertToLF.ReplaceAllLiteralString(input, "\n")
	input = htmlBreaks.ReplaceAllLiteralString(input, "\n")
	input = leadingTrailingVWS.ReplaceAllLiteralString(input, "")
	input = leadingTrailingHWS.ReplaceAllLiteralString(input, "")
	input = redundantILS.ReplaceAllLiteralString(input, " ")
	input = redundantNL.ReplaceAllLiteralString(input, "\n\n")

	return input
}
