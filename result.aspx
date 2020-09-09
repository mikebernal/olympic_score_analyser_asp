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

	static int checkGold(string medal) {
		int count = 0;
		if (medal == "Gold") {
			count = count + 1;
			return count;
		} else {
			return count;
		}
	}
	
	static int checkSilver(string medal) {
		int count = 0;
		if (medal == "Silver") {
			count = count + 1;
			return count;
		} else {
			return count;
		}
	}	

	static int checkBronze(string medal) {
		int count = 0;
		if (medal == "Bronze") {
			count = count + 1;
			return count;
		} else {
			return count;
		}
	}

	static int countMedals(int gold, int silver, int bronze) {
		int count = 0;
		count = count + gold + silver + bronze;
		return count;
	}



%>

</body>
</html>
