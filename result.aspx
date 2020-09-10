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
    <script runat="server">

        public class Country
        {
            public string country { get; set; }
            public int gold { get; set; }
            public int silver { get; set; }
            public int bronze { get; set; }
            public int totalMedals { get; set; }
        }

    </script>
<%
    // Initialize arrays
    dynamic competitors = JsonConvert.DeserializeObject(Request.Form["competitorList"]);

    dynamic sortedCountries = new List<object>();
    dynamic worldRecordList = new List<object>();

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

    /** For Printing each sorted countries
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
            //sortedCountries.Add
            //((
            //    country:     competitor["country"],
            //    gold:        checkGold(competitor["medal"]),
            //    silver:      checkSilver(competitor["medal"]),
            //    bronze:      checkBronze(competitor["medal"]),
            //    totalMedals: countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
            //));

            sortedCountries.Add(new  {
                country = competitor["country"],
                gold = checkGold(competitor["medal"]),
                silver = checkSilver(competitor["medal"]),
                bronze = checkBronze(competitor["medal"]),
                totalMedals = countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
            });

        }
        else
        {
            // Update existing country details
            var countryExists = sortedCountries.Find(x => x.country == competitor.country);
            var countryIndex = sortedCountries.FindIndex(x => x.country == competitor.country);
            if (countryExists.Count == 1)
            {
                // 2. Override existing country values
                sortedCountries[countryIndex].Add((
                    country: competitor["country"],
                    gold: (checkGold(competitor["medal"]) + Int32.Parse(sortedCountries[countryIndex]["gold"])),
                    silver: (checkSilver(competitor["medal"]) + Int32.Parse(sortedCountries[countryIndex]["silver"])),
                    bronze: (checkBronze(competitor["medal"]) + Int32.Parse(sortedCountries[countryIndex]["bronze"])),
                    totalMedals: sortedCountries[countryIndex]["total-medals"] += countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
                ));
            }
            else
            {
                // 3. Add country if it does not exists yet
                sortedCountries.Add((
                   country: competitor["country"],
                   golf: checkGold(competitor["medal"]),
                   silver: checkSilver(competitor["medal"]),
                   bronze: checkBronze(competitor["medal"]),
                   totalMedals: countMedals(checkGold(competitor["medal"]), checkSilver(competitor["medal"]), checkBronze(competitor["medal"]))
                 ));
            }

        }
    }

    foreach (var country in sortedCountries)
    {
        Response.Write(country);
    }
%>

</body>
</html>
