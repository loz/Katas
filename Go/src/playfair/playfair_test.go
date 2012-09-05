package playfair

import "testing"

var keytext string = "ABCDE" +
                     "FGHIK" +
                     "LMNOP" +
                     "QRSTU" +
                     "VWXYZ"

var subject Playfair = *NewPlayfair(keytext)

func AssertEncodings(values map[string]string, t *testing.T) {
  for plaintext, expected := range values {
    actual := subject.encode(plaintext)
    if actual != expected {
      t.Error("Expected", expected, "Got", actual)
    }
  }
}

func TestEncodesAsDownshiftedForDigraphInAColumn(t *testing.T) {
  values := map[string]string{
    "CN": "HS",
    "MW": "RB",
    "UK": "ZP",
  }
  AssertEncodings(values, t)
}

func TestEncodesAsRightshiftedForDigraphInARow(t *testing.T) {
  values := map[string]string{
    "AB": "BC",
    "KG": "FH",
    "QS": "RT",
  }
  AssertEncodings(values, t)
}
