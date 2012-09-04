package playfair

import "testing"

var keytext string = "ABCDE" +
                     "FGHIK" +
                     "LMNOP" +
                     "QRSTU" +
                     "VWXYZ"

var subject Playfair = *NewPlayfair(keytext)

func TestEncodesAsDownshiftedForDigraphInAColumn(t *testing.T) {
  values := map[string]string{
    "CN": "HS",
    "MW": "RB",
    "UK": "ZP",
  }

  for plaintext, expected := range values {
    actual := subject.encode(plaintext)
    if actual != expected {
      t.Error("Expected", expected, "Got", actual)
    }
  }
}
