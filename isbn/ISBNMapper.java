package isbn;

import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ISBNMapper {
    private int country;
    private int publisher;
    private boolean valid;
    private char checksum;
    private int type;
    private int[] numbers;
    MatchResult mr;

    public ISBNMapper(String raw) {
    System.out.println(raw);
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

    public static void main(String[] args) {
    String cases[] = { "978 0 571 08989 5", "978 5 571 08989 5",
        "978-7-302-07800-5", "978-9 861-03085 2", "987-1-2-3",
        "0-596-52831-0", "9bcasdasdlkas", "978-0-11-000222-4",
        "1-58488-540-8" };
    String[] expected = { "English 571", "Error", "Chinese 302",
        "Other 861", "Error", "English 596", "Error", "English 11",
        "Other 58488" };
    for (int i = 0; i < cases.length; ++i) {
        ISBNMapper mapper = new ISBNMapper(cases[i]);
        String actual;
        if (mapper.isValid()) {
        actual = mapper.getCountry() + " " + mapper.getPublisher();
        } else {
        actual = "Error";
        }

        if (actual.equals(expected[i]))
        System.out.println("[PASS] " + actual);
        else {
        System.out.println("[Fail] Expected: " + expected[i]
            + ", actual: " + actual);
        }
    }
    }
}

