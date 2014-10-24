import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class ISBNMapper {
    private int country;
    private int publisher;
    private boolean valid;
    private char checksum;
    private int type;
    private int[] numbers;
    MatchResult mr;

    public ISBNMapper(String raw) {
    Pattern pattern = Pattern
        .compile("(?:97[89][- ])?(\\d+[- ])(\\d+[- ])(\\d+[- ])([X\\d])");
    Matcher matcher = pattern.matcher(raw);
    if (matcher.find()) {
        String numString;
        int rawlen = raw.length();
        if (rawlen != 13 + 4 && rawlen != 10 + 3) {
        valid = false;
        return;
        }

        numString = raw.substring(0, rawlen - 1);
        type = (rawlen == 13 + 4) ? 13 : 10;

        numString = numString.replace(" ", "").replace("-", "");

        numbers = new int[type - 1];
        for (int i = 0; i < type - 1; ++i) {
        numbers[i] = Character.getNumericValue(numString.charAt(i));
        }
        checksum = raw.charAt(rawlen - 1);

        if (!isValidISBN()) {
        valid = false;
        return;
        }

        mr = matcher.toMatchResult();
        country = numberInMatch(1);
        publisher = numberInMatch(2);
        valid = true;
    } else {
        valid = false;
    }
    }

    public String getCountry() {
    if (!valid)
        return null;

    if (country == 0)
        return "English";
    else if (country == 7)
        return "Chinese";
    else
        return "Other";
    }

    public int getPublisher() {
    if (!valid)
        return -1;
    return publisher;
    }

    public boolean isValid() {
    return valid;
    }

    private int numberInMatch(int index) {
    if (index <= mr.groupCount())
        return Integer.parseInt(mr.group(index).replace(" ", "")
            .replace("-", ""));
    else {
        return -1;
    }
    }

    private boolean isValidISBN() {
    int sum = 0;
    int csnum;
    if (type == 10) {
        if (!Character.isDigit(checksum))
        csnum = 10;
        else
        csnum = Character.getNumericValue(checksum) % 11;
        for (int i = 0, j = 10; i < type - 1; ++i, --j) {
        sum += numbers[i] * j;
        }
        return csnum == (11 - (sum % 11)) % 11;
    } else {
        csnum = Character.getNumericValue(checksum);
        for (int i = 0; i < type - 1; ++i) {
        sum += numbers[i] * (i % 2 == 0 ? 1 : 3);
        }
        return csnum == (10 - (sum % 10)) % 10;
    }
    }
        
}

%%

%public
%class ISBN
%standalone
%unicode

DIGIT=[0-9]
ISBN=(97[89][\- ])?({DIGIT}+[\- ]){3}(X|{DIGIT})

%%
{ISBN}  {
    ISBNMapper mapper = new ISBNMapper(yytext());
    if (mapper.isValid()) {
        System.out.println(mapper.getCountry() + " " + mapper.getPublisher());
    } else {
        System.out.println("Error");
    }
}

. { /* skip */ }
\n { /* skip */ }
