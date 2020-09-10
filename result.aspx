<%@ Page Language="C#"%>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>

<%
    // Initialize arrays
    dynamic competitors = JsonConvert.DeserializeObject(Request.Form["competitorList"]);

    List<dynamic> sortedCountries = new List<dynamic>();
    List<dynamic> worldRecordList = new List<dynamic>();

    // World Record Array
    foreach (var competitor in competitors)
    {
        if (competitor.worldRecord == "Yes")
        {
            worldRecordList.Add(competitor);
        }
    }

    int checkGold(string medal)
    {
        int count = 0;
        if (medal == "Gold")
        {
            count = count + 1;
            return count;
        }
        else
        {
            return count;
        }
    }

    int checkSilver(string medal)
    {
        int count = 0;
        if (medal == "Silver")
        {
            count = count + 1;
            return count;
        }
        else
        {
            return count;
        }
    }

    int checkBronze(string medal)
    {
        int count = 0;
        if (medal == "Bronze")
        {
            count = count + 1;
            return count;
        }
        else
        {
            return count;
        }
    }

    int countMedals(int gold, int silver, int bronze)
    {
        int count = 0;
        count = count + gold + silver + bronze;
        return count;
    }

    /**
    for (var i =0; i < sortedCountries.Count; i += 1)
    { 
        Response.Write(sortedCountries[i]);
    }

    sortedCountries.Add
    ((
        country: competitor.Value<string>("country"),
        name: competitor.Value<string>("name")
    ));

    /*/

    // Initialize sortedCountries
    foreach(var competitor in competitors)
    {

        if (sortedCountries.Count == 0)
        {
            // 1. Add country if array is empty
            sortedCountries.Add
            ((
                country:     competitor["country"],
                gold:        checkGold(competitor["medal"]),
                silver:      checkSilver(competitor["medal"]),
                bronze:      checkBronze(competitor["medal"]),
                totalMedals: countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
            ));
        }
        else
        {
            // Update existing country details
            // var allCountries  = array_column(sortedCountries, "country");
            List<dynamic> myObject = new List<dynamic>();
            var allCountries  = sortedCountries.GetType().GetProperty("country");
            var alLCountriesVal = allCountries.GetValue(myObject, null);
            var countryExists = in_array(competitor["country"], allCountries);
            if (countryExists)
            {
               // 2. Override existing country values
               var existingCountryIndex = array_search(competitor["country"], allCountries);
                sortedCountries[existingCountryIndex] = array_merge(sortedCountries[existingCountryIndex], (
                    country:     competitor["country"],
                    gold:        ( checkGold(competitor["medal"]) + (int)sortedCountries[existingCountryIndex]["gold"] ),
                    silver:      ( checkSilver(competitor["medal"]) + (int)sortedCountries[existingCountryIndex]["silver"] ),
                    bronze:      ( checkBronze(competitor["medal"]) + (int)sortedCountries[existingCountryIndex]["bronze"] ),
                    totalMedals: sortedCountries[existingCountryIndex]["total-medals"] += countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
                ));
            }
            else
            {
               // 3. Add country 
               sortedCountries.Add((
                  country:     competitor["country"],
                  golf:        checkGold(competitor["medal"]),
                  silver:      checkSilver(competitor["medal"]),
                  bronze:      checkBronze(competitor["medal"]),
                  totalMedals: countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
                ));
            }

        }
    }

%>

</body>
</html>
